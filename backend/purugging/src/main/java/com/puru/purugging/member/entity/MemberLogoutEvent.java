package com.puru.purugging.member.entity;

import lombok.Getter;

@Getter
public class MemberLogoutEvent {

    private Long memberId;

    public MemberLogoutEvent(Long memberId) {
        this.memberId = memberId;
    }
}
