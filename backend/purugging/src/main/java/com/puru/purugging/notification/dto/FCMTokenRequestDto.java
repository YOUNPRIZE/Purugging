package com.puru.purugging.notification.dto;


import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class FCMTokenRequestDto {
    private Long memberId;
    private String FCMToken;

    @Builder
    public FCMTokenRequestDto(Long memberId, String FCMToken) {
        this.memberId = memberId;
        this.FCMToken = FCMToken;
    }
}
