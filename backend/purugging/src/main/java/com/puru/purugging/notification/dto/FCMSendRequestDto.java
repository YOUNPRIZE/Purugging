package com.puru.purugging.notification.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class FCMSendRequestDto {
    private Long userId;
    private String title;
    private String body;

    @Builder
    public FCMSendRequestDto(Long userId, String title, String body) {
        this.userId = userId;
        this.title = title;
        this.body = body;
    }
}
