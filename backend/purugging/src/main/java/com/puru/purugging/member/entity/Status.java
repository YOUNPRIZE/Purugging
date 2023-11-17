package com.puru.purugging.member.entity;

public enum Status {
    ACTIVE("정상 회원"),
    INACTIVE("탈퇴 회원"),
    NOT_REGISTERED("미가입 회원"); // DB에는 미가입 회원 상태가 입력되지 않습니다.

    private final String description;

    Status(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
