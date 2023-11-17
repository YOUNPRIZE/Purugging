package com.puru.purugging.common.mqtt.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.puru.purugging.machine.controller.MachineController;
import com.puru.purugging.machine.dto.RemainingCapacityUpdateRequestDto;
import com.puru.purugging.machine.exception.MachineException;
import com.puru.purugging.plogging.controller.PloggingController;
import com.puru.purugging.plogging.dto.PloggingUpdateRequestDto;
import com.puru.purugging.plogging.entity.Plogging;
import com.puru.purugging.plogging.exception.PloggingException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.Message;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class MqttMessageHandler {

    private final MqttPublisher mqttPublisher;
    private final PloggingController ploggingController;
    private final MachineController machineController;
    private final ObjectMapper objectMapper;

    public void handleMqttMessage(Message<?> message) {
        String payload = String.valueOf(message.getPayload());
        // 구체적인 메시지 처리 로직을 여기에 추가
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(payload);

            // 추출한 데이터 활용
            if (jsonNode.get("request").asText().equals("plogging")) {
                dispatchPloggingStatus(jsonNode);
            } else if (jsonNode.get("request").asText().equals("machine")) {
                dispatchMachineRequest(jsonNode);
            }

            // 추가로 필요한 로직을 처리할 수 있습니다.
        } catch (IOException e) {
            mqttPublisher.publish("Error", e.getMessage());
        }
    }

    private void dispatchPloggingStatus(JsonNode jsonNode) throws JsonProcessingException {

        // JSON에서 필요한 데이터 추출
        Long memberId = jsonNode.get("member-id").asLong();
        String ploggingStatus = jsonNode.get("plogging-status").asText();
        System.out.println(ploggingStatus);
        Long machineId = jsonNode.get("machine-id").asLong();
        Map<String, Object> result = new HashMap<>();
        result.put("member-id", memberId);
        result.put("machine-id", machineId);

        // ploggingStatus 값에 따라 서비스 메서드 호출
        try {
            if (ploggingStatus.equals("PLOGGING_INCOMPLETE")) {
                Plogging plogging = ploggingController.ploggingInitiation(memberId,
                        machineId);

                result.put("plogging-id", plogging.getId());
                result.put("result", "success");
                result.put("message", "initiation-success");
                String jsonPayload = objectMapper.writeValueAsString(result);// Map을 JSON 문자열로 변환

                mqttPublisher.publish("Server", jsonPayload);

            } else if (ploggingStatus.equals("PLOGGOGING_IN_PROGRESS")) {
                Long distance = jsonNode.get("distance").asLong();
                Plogging plogging = ploggingController.ploggingTermination(memberId, machineId,
                        distance);

                result.put("plogging-id", plogging.getId());
                result.put("result", "success");
                result.put("message", "termination-success");
                String jsonPayload = objectMapper.writeValueAsString(result);// Map을 JSON 문자열로 변환

                mqttPublisher.publish("Server", jsonPayload);

            } else if (ploggingStatus.equals("PLOGGIGNG_PENDING_COMPLETION")) {
                Plogging plogging = ploggingController.ploggingPendingClosure(memberId);

                result.put("plogging-id", plogging.getId());
                result.put("result", "success");
                result.put("message", "pending-success");
                String jsonPayload = objectMapper.writeValueAsString(result);// Map을 JSON 문자열로 변환

                mqttPublisher.publish("Server", jsonPayload);

            } else if (ploggingStatus.equals("PLOGGIGNG_COMPLETED")) {
                Plogging plogging = ploggingController.ploggingUpdate(memberId,
                        PloggingUpdateRequestDto.from(jsonNode.get("plogging-update-request-dto")));

                result.put("plogging-id", plogging.getId());
                result.put("result", "success");
                result.put("message", "update-success");
                String jsonPayload = objectMapper.writeValueAsString(result);// Map을 JSON 문자열로 변환

                mqttPublisher.publish("Server", jsonPayload);

            } else {
                result.put("result", "error");
                result.put("message", "일치하는 상태값이 없습니다");
                String jsonPayload = objectMapper.writeValueAsString(result);// Map을 JSON 문자열로 변환
                mqttPublisher.publish("Error", jsonPayload);
            }
        } catch (PloggingException pe) {
            result.put("result", "error");
            result.put("message", pe.getMessage());
            String jsonPayload = objectMapper.writeValueAsString(result);// Map을 JSON 문자열로 변환
            mqttPublisher.publish("Error", jsonPayload);
        }
    }

    private void dispatchMachineRequest(JsonNode jsonNode) throws JsonProcessingException {

        String requestType = jsonNode.get("request-type").asText();
        Long machineId = jsonNode.get("machine-id").asLong();

        Map<String, Object> result = new HashMap<>();
        result.put("machine-id", machineId);

        try {
            if (requestType.equals("update")) {
                RemainingCapacityUpdateRequestDto requestDto = RemainingCapacityUpdateRequestDto.from(
                        jsonNode.get("machine-update-request-dto"));

                machineController.remainingCapacityUpdate(machineId, requestDto);

                result.put("result", "success");
                result.put("message", "machine-update-success");
                String jsonPayload = objectMapper.writeValueAsString(result);
                mqttPublisher.publish("Server", jsonPayload);

            } else if (requestType.equals("reset")) {

                machineController.remainingCapacityReset(machineId);

                result.put("result", "success");
                result.put("message", "machine-reset-success");
                String jsonPayload = objectMapper.writeValueAsString(result);
                mqttPublisher.publish("Server", jsonPayload);

            } else {
                result.put("result", "error");
                result.put("message", "일치하는 상태값이 없습니다");
                String jsonPayload = objectMapper.writeValueAsString(result);
                mqttPublisher.publish("Error", jsonPayload);
            }
        } catch (MachineException me) {
            result.put("result", "error");
            result.put("message", me.getMessage());
            String jsonPayload = objectMapper.writeValueAsString(result);// Map을 JSON 문자열로 변환
            mqttPublisher.publish("Error", jsonPayload);
        }
    }
}
