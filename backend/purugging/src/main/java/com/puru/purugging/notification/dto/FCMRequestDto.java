package com.puru.purugging.notification.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class FCMRequestDto {
    private Long userId;
    private String title;
    private String body;

    @Builder
    public FCMRequestDto(Long userId, String title, String body) {
        this.userId = userId;
        this.title = title;
        this.body = body;
    }
}
