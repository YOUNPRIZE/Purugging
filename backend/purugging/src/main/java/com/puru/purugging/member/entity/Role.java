package com.puru.purugging.member.entity;

public enum Role {
    ADMIN("관리자"),
    MEMBER("일반 회원");

    private final String description;

    Role(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}