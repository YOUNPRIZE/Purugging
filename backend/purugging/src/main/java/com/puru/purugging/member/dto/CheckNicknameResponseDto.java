package com.puru.purugging.member.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.AllArgsConstructor;
import lombok.Builder;

@Builder
@AllArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class CheckNicknameResponseDto {
    boolean isNicknameAvailable;

    public static CheckNicknameResponseDto from(boolean isNicknameAvailable) {
        return CheckNicknameResponseDto.builder()
                .isNicknameAvailable(isNicknameAvailable)
                .build();
    }
}
