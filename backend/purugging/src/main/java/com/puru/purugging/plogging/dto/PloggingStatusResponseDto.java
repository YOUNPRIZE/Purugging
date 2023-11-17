package com.puru.purugging.plogging.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.plogging.entity.Plogging.PloggingStatus;
import com.puru.purugging.plogging.entity.PloggingStatusInfo;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class PloggingStatusResponseDto {

    private Long ploggingId;
    private Long memberId;
    private PloggingStatus ploggingStatus;

    @Builder
    public PloggingStatusResponseDto(Long ploggingId, Long memberId,
            PloggingStatus ploggingStatus) {
        this.ploggingId = ploggingId;
        this.memberId = memberId;
        this.ploggingStatus = ploggingStatus;
    }

    public static PloggingStatusResponseDto from(PloggingStatusInfo result) {
        return PloggingStatusResponseDto.builder()
                                        .ploggingId(result.getPloggingId())
                                        .memberId(result.getMemberId())
                                        .ploggingStatus(result.getPloggingStatus())
                                        .build();
    }
}
