package com.puru.purugging.plogging.exception;

import com.puru.purugging.common.exception.CustomException;
import com.puru.purugging.common.exception.ErrorCode;

public class PloggingException extends CustomException {

    public PloggingException(String message, ErrorCode errorCode) {
        super(message, errorCode);
    }

    public PloggingException(ErrorCode errorCode) {
        super(errorCode);
    }
}
