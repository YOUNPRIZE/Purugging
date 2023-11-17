package com.puru.purugging.plogging.exception;

import com.puru.purugging.common.exception.ErrorCode;
import lombok.Getter;

@Getter
public enum PloggingErrorcode implements ErrorCode {
    NOT_FOUND_PLOGGING("해당 플로깅을 찾을 수 없습니다.", "PLG_001", 404),
    CANNOT_PROCEED_PLOGGING("다음 플로깅 상태로 진행할 수 없습니다.", "PLG_002", 403),
    CANNOT_FIND_PLOGGING("플로깅이 조회 가능한 상태가 아닙니다.", "PLG_003", 403),
    PLOGGING_IMAGE_EXISTS("이미 플로깅 이미지가 존재합니다.", "PLG_004", 409), //409-Conflict: 클라이언트에게 요청한 데이터가 이미 존재하고, 새로운 데이터를 추가하려는 것이 충돌함을 표현
    NOT_FOUND_CONTENTS("해당 플로깅 페이지를 만들 수 없습니다.", "PLG_005", 404);



    private final String message;
    private final String errorCode;
    private final int statusCode;

    PloggingErrorcode(String message, String errorCode, int statusCode) {
        this.message = message;
        this.errorCode = errorCode;
        this.statusCode = statusCode;
    }
}
