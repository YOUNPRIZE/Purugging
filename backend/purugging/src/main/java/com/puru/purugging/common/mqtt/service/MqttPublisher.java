package com.puru.purugging.common.mqtt.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.integration.mqtt.outbound.MqttPahoMessageHandler;
import org.springframework.integration.support.MessageBuilder;
import org.springframework.messaging.Message;

@RequiredArgsConstructor
public class MqttPublisher {

    private final MqttPahoMessageHandler mqttOutbound;

    public void publish(String topic, String payload) {
        // 메시지 발행 로직
        // topic 및 payload를 사용하여 MQTT 메시지를 발행합니다.
        Message<String> message = MessageBuilder.withPayload(payload).setHeader("mqtt_topic", topic).build();
        mqttOutbound.handleMessage(message);
    }

//    public void publish(String topic, Map<String, Object> payload) throws JsonProcessingException {
//        // 메시지 발행 로직
//        // topic 및 payload를 사용하여 MQTT 메시지를 발행합니다.
//        Message<String> message = MessageBuilder.withPayload(jsonPayload).setHeader("mqtt_topic", topic).build();
//        mqttOutbound.handleMessage(message);
//    }
}
