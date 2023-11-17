package com.puru.purugging.member.entity;

public enum Gender {
    MALE("남성"),
    FEMALE("여성"),
    OTHER("기타"),
    UNKNOWN("알 수 없음");

    private final String description;

    Gender(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}

