package com.puru.purugging.machine.controller;

import com.puru.purugging.common.response.ResponseFactory;
import com.puru.purugging.machine.dto.MachineCreationRequestDto;
import com.puru.purugging.machine.dto.MachineDetailsResponseDto;
import com.puru.purugging.machine.dto.MachineListResponseDto;
import com.puru.purugging.machine.dto.RemainingCapacityUpdateRequestDto;
import com.puru.purugging.machine.entity.Machine;
import com.puru.purugging.machine.service.MachineService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/machines")
@RequiredArgsConstructor
public class MachineController {

    private final MachineService machineService;

    //머신 생성(등록)
    @PostMapping
    public ResponseEntity<?> machineCreation(@RequestBody MachineCreationRequestDto request) {

        machineService.createMachine(MachineCreationRequestDto.to(request));

        return ResponseFactory.success("기기 등록 성공");
    }

    //봉투 채우기
    @PatchMapping("/{machine-id}")
    public ResponseEntity<?> bagReplenishment(@PathVariable("machine-id") Long machineId,
            @RequestParam Long bags) {

        machineService.refillBags(machineId, bags);

        return ResponseFactory.success("비닐 리필 성공");
    }

    //머신 삭제
    @DeleteMapping("/{machine-id}")
    public ResponseEntity<?> machineRemoval(@PathVariable("machine-id") Long machineId) {

        machineService.deleteMachine(machineId);

        return ResponseFactory.success("기기 삭제 성공");
    }

    //머신 상세 조회
    @GetMapping("/{machine-id}")
    public ResponseEntity<?> machineDetails(@PathVariable("machine-id") Long machineId) {

        Machine result = machineService.findMachine(machineId);

        return ResponseFactory.success("기기 디테일 조회 성공", MachineDetailsResponseDto.from(result));
    }

    //머신 전체 조회
    @GetMapping
    public ResponseEntity<?> machineList() {

        List<Machine> result = machineService.findAllMachine();

        return ResponseFactory.success("기기 리스트 조회 성공", MachineListResponseDto.from(result));
    }

    //누적 값 받기 - MQTT
    public void remainingCapacityUpdate(Long machineId, RemainingCapacityUpdateRequestDto request) {

        machineService.updateRemainingCapacity(machineId,
                RemainingCapacityUpdateRequestDto.to(request));
    }

    //누적 값 리셋 - MQTT
    public void remainingCapacityReset(Long machineId) {

        machineService.resetRemainingCapacity(machineId);
    }
}
