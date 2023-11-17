package com.puru.purugging.member.entity;

import lombok.Getter;

@Getter
public class MemberLoginEvent {
    private Long memberId;

    public MemberLoginEvent(Long memberId) {
        this.memberId = memberId;
    }
}
