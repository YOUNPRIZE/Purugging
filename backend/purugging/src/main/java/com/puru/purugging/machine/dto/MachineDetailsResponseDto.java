package com.puru.purugging.machine.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.machine.entity.Machine;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class MachineDetailsResponseDto {

    private Long id;
    private Long bagCapacity;
    private Long petTotalCapacity;
    private Long canTotalCapacity;
    private Long trashTotalCapacity;
    private Long petRemainingCapacity;
    private Long canRemainingCapacity;
    private Long trashRemainingCapacity;
    private Long petFilledCapacity;
    private Long canFilledCapacity;
    private Long trashFilledCapacity;
    private Double machineX;
    private Double machineY;

    @Builder
    public MachineDetailsResponseDto(Long id, Long bagCapacity, Long petTotalCapacity,
            Long canTotalCapacity, Long trashTotalCapacity, Long petRemainingCapacity,
            Long canRemainingCapacity, Long trashRemainingCapacity, Long petFilledCapacity,
            Long canFilledCapacity, Long trashFilledCapacity, Double machineX, Double machineY) {
        this.id = id;
        this.bagCapacity = bagCapacity;
        this.petTotalCapacity = petTotalCapacity;
        this.canTotalCapacity = canTotalCapacity;
        this.trashTotalCapacity = trashTotalCapacity;
        this.petRemainingCapacity = petRemainingCapacity;
        this.canRemainingCapacity = canRemainingCapacity;
        this.trashRemainingCapacity = trashRemainingCapacity;
        this.petFilledCapacity = petFilledCapacity;
        this.canFilledCapacity = canFilledCapacity;
        this.trashFilledCapacity = trashFilledCapacity;
        this.machineX = machineX;
        this.machineY = machineY;
    }

    public static MachineDetailsResponseDto from(Machine result) {
        return MachineDetailsResponseDto.builder()
                                        .id(result.getId())
                                        .bagCapacity(result.getBagCapacity())
                                        .petTotalCapacity(result.getPetTotalCapacity())
                                        .canTotalCapacity(result.getCanTotalCapacity())
                                        .trashTotalCapacity(result.getTrashTotalCapacity())
                                        .petRemainingCapacity(result.getPetRemainingCapacity())
                                        .canRemainingCapacity(result.getCanRemainingCapacity())
                                        .trashRemainingCapacity(result.getTrashRemainingCapacity())
                                        .petFilledCapacity(result.getPetFilledCapacity())
                                        .canFilledCapacity(result.getCanFilledCapacity())
                                        .trashFilledCapacity(result.getTrashFilledCapacity())
                                        .machineX(result.getMachineX())
                                        .machineY(result.getMachineY())
                                        .build();
    }
}
