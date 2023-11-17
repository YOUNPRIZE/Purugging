package com.puru.purugging.member.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class MemberSignUpRequestDto {
    private String name;
    private String nickname;
    private String phoneNumber;
    private String email;
    private String imageUrl;
    private String googleUid;
}
