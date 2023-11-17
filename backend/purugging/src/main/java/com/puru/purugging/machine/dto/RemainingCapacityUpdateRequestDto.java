package com.puru.purugging.machine.dto;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.machine.entity.Machine;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class RemainingCapacityUpdateRequestDto {

    private Long petRemainingCapacity;
    private Long canRemainingCapacity;
    private Long trashRemainingCapacity;

    @Builder
    public RemainingCapacityUpdateRequestDto(Long petRemainingCapacity, Long canRemainingCapacity,
                                             Long trashRemainingCapacity) {
        this.petRemainingCapacity = petRemainingCapacity;
        this.canRemainingCapacity = canRemainingCapacity;
        this.trashRemainingCapacity = trashRemainingCapacity;
    }

    public static Machine to(RemainingCapacityUpdateRequestDto request) {
        return Machine.builder()
                      .petRemainingCapacity(request.getPetRemainingCapacity())
                      .canRemainingCapacity(request.getCanRemainingCapacity())
                      .trashRemainingCapacity(request.getTrashRemainingCapacity())
                      .build();
    }

    public static RemainingCapacityUpdateRequestDto from(JsonNode jsonNode) {
        return RemainingCapacityUpdateRequestDto.builder()
                                                .petRemainingCapacity(jsonNode.get("pet").asLong())
                                                .canRemainingCapacity(jsonNode.get("can").asLong())
                                                .trashRemainingCapacity(jsonNode.get("trash").asLong())
                                                .build();

    }
}
