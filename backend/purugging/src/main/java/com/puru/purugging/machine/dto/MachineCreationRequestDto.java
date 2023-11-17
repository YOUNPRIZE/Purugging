package com.puru.purugging.machine.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.machine.entity.Machine;
import javax.persistence.Column;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class MachineCreationRequestDto {

    private Long bagCapacity;
    private Long petTotalCapacity;
    private Long canTotalCapacity;
    private Long trashTotalCapacity;
    private Double machineX;
    private Double machineY;

    @Builder
    public MachineCreationRequestDto(Long bagCapacity, Long petTotalCapacity, Long canTotalCapacity,
            Long trashTotalCapacity, Double machineX, Double machineY) {
        this.bagCapacity = bagCapacity;
        this.petTotalCapacity = petTotalCapacity;
        this.canTotalCapacity = canTotalCapacity;
        this.trashTotalCapacity = trashTotalCapacity;
        this.machineX = machineX;
        this.machineY = machineY;
    }

    public static Machine to(MachineCreationRequestDto request) {
        return Machine.builder()
                      .bagCapacity(request.getBagCapacity())
                      .petTotalCapacity(request.getPetTotalCapacity())
                      .canTotalCapacity(request.getCanTotalCapacity())
                      .trashTotalCapacity(request.getTrashTotalCapacity())
                      .petRemainingCapacity(request.getPetTotalCapacity())
                      .canRemainingCapacity(request.getCanTotalCapacity())
                      .trashRemainingCapacity(request.getTrashTotalCapacity())
                      .petFilledCapacity(0L)
                      .canFilledCapacity(0L)
                      .trashFilledCapacity(0L)
                      .machineX(request.getMachineX())
                      .machineY(request.getMachineY())
                      .build();
    }
}
