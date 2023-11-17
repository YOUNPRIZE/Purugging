package com.puru.purugging.member.exception;

import com.puru.purugging.common.exception.CustomException;
import com.puru.purugging.common.exception.ErrorCode;

public class MemberException extends CustomException {

    public MemberException(ErrorCode errorCode) {
        super(errorCode);
    }
}
