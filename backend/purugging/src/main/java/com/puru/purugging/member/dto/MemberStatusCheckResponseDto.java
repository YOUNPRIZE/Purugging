package com.puru.purugging.member.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.member.entity.Member;
import com.puru.purugging.member.entity.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class MemberStatusCheckResponseDto {
    private Long memberId;
    private Status status;

    public static MemberStatusCheckResponseDto from(Member member) {
        return MemberStatusCheckResponseDto.builder()
                .memberId(member.getId())
                .status(member.getStatus())
                .build();
    }
}
