package com.puru.purugging.plogging.dto;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.plogging.entity.Plogging;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class PloggingUpdateRequestDto {

    private Double generalTrashWeight;
    private Long petCount;
    private Long canCount;

    @Builder
    public PloggingUpdateRequestDto(Double generalTrashWeight, Long petCount,
            Long canCount) {
        this.generalTrashWeight = generalTrashWeight;
        this.petCount = petCount;
        this.canCount = canCount;
    }

    public static Plogging to(PloggingUpdateRequestDto request) {
        return Plogging.builder()
                .generalTrashWeight(request.getGeneralTrashWeight())
                .petCount(request.getPetCount())
                .canCount(request.getCanCount())
                .build();
    }

    public static PloggingUpdateRequestDto from(JsonNode ploggingUpdateRequestDtoNode) {
        System.out.println(ploggingUpdateRequestDtoNode);
        return PloggingUpdateRequestDto.builder()
                .generalTrashWeight(ploggingUpdateRequestDtoNode.get("generalTrashWeight").asDouble())
                .petCount(ploggingUpdateRequestDtoNode.get("petCount").asLong())
                .canCount(ploggingUpdateRequestDtoNode.get("canCount").asLong())
                .build();
    }
}
