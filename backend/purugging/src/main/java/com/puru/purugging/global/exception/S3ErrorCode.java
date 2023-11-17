package com.puru.purugging.global.exception;

import com.puru.purugging.common.exception.ErrorCode;
import lombok.Getter;

@Getter
public enum S3ErrorCode implements ErrorCode {

    FAIL_UPLOAD_S3("S3 업로드를 실패했습니다.", "EXP_001", 404);

    private final String message;
    private final String errorCode;
    private final int statusCode;

    S3ErrorCode(String message, String errorCode, int statusCode) {
        this.message = message;
        this.errorCode = errorCode;
        this.statusCode = statusCode;
    }

}
