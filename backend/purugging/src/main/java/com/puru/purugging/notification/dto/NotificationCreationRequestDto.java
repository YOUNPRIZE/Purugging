package com.puru.purugging.notification.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.notification.entity.Notification;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class NotificationCreationRequestDto {
    private String title;
    private String content;

    @Builder
    public NotificationCreationRequestDto(String title, String content) {
        this.title = title;
        this.content = content;
    }

    public static Notification to (NotificationCreationRequestDto request) {
        return Notification.builder()
                .title(request.getTitle())
                .content(request.getContent())
                .build();
    }
}
