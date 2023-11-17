package com.puru.purugging.member.entity;


import com.puru.purugging.common.model.BaseTimeEntity;
import com.puru.purugging.global.vo.Image;
import com.puru.purugging.member.dto.MemberSignUpRequestDto;
import com.puru.purugging.member.dto.MyModifyRequestDto;
import lombok.*;

import javax.persistence.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Getter
@Setter
public class Member extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id", nullable = false)
    private Long id;

    @Column(name = "google_uid")
    private String googleUid;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "imageUrl", column = @Column(name = "profile_image_url")),
            @AttributeOverride(name = "imageType", column = @Column(name = "profile_image_type")),
            @AttributeOverride(name = "imageName", column = @Column(name = "profile_image_name")),
            @AttributeOverride(name = "imageUUID", column = @Column(name = "profile_image_uuid"))
    })
    private Image profileImage;

    @Column(name = "email")
    private String email;

    @Column(name = "name")
    private String name;

    @Column(name = "nickname")
    private String nickname;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender")
    private Gender gender = Gender.UNKNOWN;

    @Column(name = "introduction")
    private String introduction;

    @Enumerated(EnumType.STRING)
    @Column(name = "grade")
    private Grade grade = Grade.SPROUT;

    private Double cumWeight = 0.0;

    @Column(name = "cum_pet")
    private Long cumPet = 0L;

    @Column(name = "cum_can")
    private Long cumCan = 0L;

    @Column(name = "plogging_cnt")
    private Long ploggingCnt = 0L;

    @Column(name = "campaign_cnt")
    private Long campaignCnt = 0L;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private Status status = Status.ACTIVE;

    @Enumerated(EnumType.STRING)
    @Column(name = "role")
    private Role role = Role.MEMBER;

    public Member(MemberSignUpRequestDto memberSignUpRequestDto) {
        this.name = memberSignUpRequestDto.getName();
        this.nickname = memberSignUpRequestDto.getNickname();
        this.phoneNumber = memberSignUpRequestDto.getPhoneNumber();
        this.email = memberSignUpRequestDto.getEmail();
        this.profileImage = new Image();
        this.profileImage.setImageUrl(memberSignUpRequestDto.getImageUrl());
        this.googleUid = memberSignUpRequestDto.getGoogleUid();
    }

    public void reJoin(MemberSignUpRequestDto memberSignUpRequestDto) {
        this.name = memberSignUpRequestDto.getName();
        this.nickname = memberSignUpRequestDto.getNickname();
        this.phoneNumber = memberSignUpRequestDto.getPhoneNumber();
        this.email = memberSignUpRequestDto.getEmail();
        this.profileImage = new Image();
        this.profileImage.setImageUrl(memberSignUpRequestDto.getImageUrl());
        this.googleUid = memberSignUpRequestDto.getGoogleUid();
        this.status = Status.ACTIVE;
    }

    public void updateInfo(MyModifyRequestDto myModifyRequestDto) {
        if (myModifyRequestDto.getNickname() != null) this.nickname = myModifyRequestDto.getNickname();
        if (myModifyRequestDto.getPhoneNumber() != null) this.phoneNumber = myModifyRequestDto.getPhoneNumber();
        if (myModifyRequestDto.getGender() != null) {
            if (myModifyRequestDto.getGender() == "남성") {
                this.gender = Gender.MALE;
            } else if (myModifyRequestDto.getGender() == "여성") {
                this.gender = Gender.FEMALE;
            } else {
                this.gender = Gender.OTHER;
            }
        }
        if (myModifyRequestDto.getIntroduction() != null) this.introduction = myModifyRequestDto.getIntroduction();
    }

}