package com.puru.purugging.common.exception;

public enum CommonErrorCode implements ErrorCode{
    INVALID_INPUT("잘못된 입력 값입니다.","COM_001",400),
    UN_AUTHORIZATION("인증이 필요합니다.","COM_002",401),
    FORBIDN("권한이 필요합니다", "COM_003",403),
    NOT_FOUND_RESOURCE("해당 자원을 찾을 수 없습니다","COM_004", 404),
    SERVER_ERROR("서버의 상태가 이상합니다","COM_005",500);
    private String message;
    private String errorCode;
    private int statusCode;

    CommonErrorCode(String message, String errorCode, int statusCode) {
        this.message = message;
        this.errorCode = errorCode;
        this.statusCode = statusCode;
    }

    @Override
    public String getMessage() {
        return this.message;
    }

    @Override
    public String getErrorCode() {
        return this.errorCode;
    }

    @Override
    public int getStatusCode() {
        return this.statusCode;
    }
}
