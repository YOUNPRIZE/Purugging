package com.puru.purugging.notification.exception;

import com.puru.purugging.common.exception.CustomException;
import com.puru.purugging.common.exception.ErrorCode;

public class NotificationException extends CustomException {

    public NotificationException(String message, ErrorCode errorCode) {
        super(message, errorCode);
    }

    public NotificationException(ErrorCode errorCode) {
        super(errorCode);
    }
}
