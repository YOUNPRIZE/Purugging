package com.puru.purugging.member.entity;

public enum Grade {
    SEED("씨앗 등급"),
    SPROUT("새싹 등급"),
    LEAF("잎새 등급"),
    BRANCH("가지 등급"),
    FRUIT("열매 등급"),
    TREE("나무 등급");

    private final String description;

    Grade(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}