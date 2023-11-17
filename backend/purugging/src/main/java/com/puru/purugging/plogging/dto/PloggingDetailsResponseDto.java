package com.puru.purugging.plogging.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.global.vo.Image;
import com.puru.purugging.plogging.entity.Plogging;
import com.puru.purugging.plogging.entity.Plogging.PloggingStatus;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class PloggingDetailsResponseDto {

    private Long ploggingId;
    private Long memberId;
    private Long startMachineId;
    private Long endMachineId;
    private Double generalTrashWeight;
    private Long petCount;
    private Long canCount;
    private PloggingStatus ploggingStatus;
    private Image ploggingImage;
    private LocalDateTime createDate;
    private LocalDateTime updateDate;
    private Long distance;

    @Builder
    public PloggingDetailsResponseDto(Long ploggingId, Long memberId, Long startMachineId,
            Long endMachineId, Double generalTrashWeight, Long petCount, Long canCount,
            PloggingStatus ploggingStatus, Image ploggingImage, LocalDateTime createDate, LocalDateTime updateDate, Long distance) {
        this.ploggingId = ploggingId;
        this.memberId = memberId;
        this.startMachineId = startMachineId;
        this.endMachineId = endMachineId;
        this.generalTrashWeight = generalTrashWeight;
        this.petCount = petCount;
        this.canCount = canCount;
        this.ploggingStatus = ploggingStatus;
        this.ploggingImage = ploggingImage;
        this.createDate = createDate;
        this.updateDate = updateDate;
        this.distance = distance;
    }

    public static PloggingDetailsResponseDto from(Plogging result) {
        return PloggingDetailsResponseDto.builder()
                                         .ploggingId(result.getId())
                                         .memberId(result.getMemberId())
                                         .startMachineId(result.getStartMachineId())
                                         .endMachineId(result.getEndMachineId())
                                         .generalTrashWeight(result.getGeneralTrashWeight())
                                         .petCount(result.getPetCount())
                                         .canCount(result.getCanCount())
                                         .ploggingStatus(result.getPloggingStatus())
                                         .ploggingImage(result.getPloggingImage())
                                         .createDate(result.getCreateDate())
                                         .updateDate(result.getUpdateDate())
                                         .distance(result.getDistance())
                                         .build();
    }
}
