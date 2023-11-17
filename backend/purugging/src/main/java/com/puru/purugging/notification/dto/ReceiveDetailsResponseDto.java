package com.puru.purugging.notification.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.notification.entity.Receive;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class ReceiveDetailsResponseDto {
    private Long id;
    private Long memberId;
    private Long notiId;
    private Receive.ReceiveStatus receiveStatus;

    @Builder
    public ReceiveDetailsResponseDto(Long id, Long memberId, Long notiId, Receive.ReceiveStatus receiveStatus) {
        this.id = id;
        this.memberId = memberId;
        this.notiId = notiId;
        this.receiveStatus = receiveStatus;
    }

    public static ReceiveDetailsResponseDto from(Receive result) {
        return ReceiveDetailsResponseDto.builder()
                .id(result.getId())
                .memberId(result.getMemberId())
                .notiId(result.getNotiId())
                .receiveStatus(result.getStatus())
                .build();
    }
}
