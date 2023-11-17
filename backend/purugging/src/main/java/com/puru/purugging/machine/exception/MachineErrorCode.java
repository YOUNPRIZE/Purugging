package com.puru.purugging.machine.exception;

import com.puru.purugging.common.exception.ErrorCode;
import lombok.Getter;

@Getter
public enum MachineErrorCode implements ErrorCode {
    NOT_FOUND_MACHINE("해당 기기를 찾을 수 없습니다.", "MCH_001", 404);

    private final String message;
    private final String errorCode;
    private final int statusCode;

    MachineErrorCode(String message, String errorCode, int statusCode) {
        this.message = message;
        this.errorCode = errorCode;
        this.statusCode = statusCode;
    }
}
