package com.puru.purugging.global.exception;

import com.puru.purugging.common.exception.CustomException;
import com.puru.purugging.common.exception.ErrorCode;

public class S3Exception extends CustomException {

    public S3Exception(ErrorCode errorCode) {
        super(errorCode);
    }
}
