package com.puru.purugging.common.response;


import lombok.Getter;

@Getter
public class FailResponseDto {

    private String message;
    private String errorCode;

    public FailResponseDto(String message, String errorCode) {
        this.message = message;
        this.errorCode = errorCode;
    }
}
