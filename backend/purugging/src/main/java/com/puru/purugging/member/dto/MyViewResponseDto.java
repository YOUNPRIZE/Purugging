package com.puru.purugging.member.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.global.vo.Image;
import com.puru.purugging.member.entity.Gender;
import com.puru.purugging.member.entity.Grade;
import com.puru.purugging.member.entity.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class MyViewResponseDto {
    private Image profileImage;
    private String email;
    private String name;
    private String nickname;
    private String phoneNumber;
    private Gender gender;
    private String introduction;
    private Grade grade;
    private Double cumWeight;
    private Long cumPet;
    private Long cumCan;
    private Long ploggingCnt;

    public static MyViewResponseDto from(Member member) {
        return MyViewResponseDto.builder()
                .profileImage(member.getProfileImage())
                .email(member.getEmail())
                .name(member.getName())
                .nickname(member.getNickname())
                .phoneNumber(member.getPhoneNumber())
                .gender(member.getGender())
                .introduction(member.getIntroduction())
                .grade(member.getGrade())
                .cumWeight(member.getCumWeight())
                .cumPet(member.getCumPet())
                .cumCan(member.getCumCan())
                .ploggingCnt(member.getPloggingCnt())
                .build();
    }
}
