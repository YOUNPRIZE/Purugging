package com.puru.purugging.member.exception;

import com.puru.purugging.common.exception.ErrorCode;

public enum MemberErrorCode implements ErrorCode {

    NOT_FOUND_MEMBER("해당 회원을 찾을 수 없습니다", "EXP_001", 404),
    ALREADY_EXIST_MEMBER("이미 존재하는 회원입니다.", "EXO_002", 409),
    WRONG_LOGIN_INFO("비밀번호가 잘못되었습니다.", "EXO_003", 410);

    private final String message;
    private final String errorCode;
    private final int statusCode;

    MemberErrorCode(String message, String errorCode, int statusCode) {
        this.message = message;
        this.errorCode = errorCode;
        this.statusCode = statusCode;
    }

    @Override
    public String getMessage() {
        return null;
    }

    @Override
    public String getErrorCode() {
        return null;
    }

    @Override
    public int getStatusCode() {
        return 0;
    }
}
