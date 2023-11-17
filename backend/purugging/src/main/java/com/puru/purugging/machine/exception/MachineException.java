package com.puru.purugging.machine.exception;

import com.puru.purugging.common.exception.CustomException;
import com.puru.purugging.common.exception.ErrorCode;

public class MachineException extends CustomException {

    public MachineException(String message, ErrorCode errorCode) {
        super(message, errorCode);
    }

    public MachineException(ErrorCode errorCode) {
        super(errorCode);
    }
}
