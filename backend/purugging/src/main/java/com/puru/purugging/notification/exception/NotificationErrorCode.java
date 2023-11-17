package com.puru.purugging.notification.exception;


import com.puru.purugging.common.exception.ErrorCode;
import lombok.Getter;

@Getter
public enum NotificationErrorCode implements ErrorCode {

    NOT_FOUND_NOTIFICATION("해당 알림을 찾을 수 없습니다", "NOT_001", 404),
    NOT_FOUND_RECEIVE("해당 알림을 찾을 수 없습니다", "REC_001", 404);

    private final String message;
    private final String errorCode;
    private final int statusCode;

    NotificationErrorCode(String message, String errorCode, int statusCode) {
        this.message = message;
        this.errorCode = errorCode;
        this.statusCode = statusCode;
    }
}
