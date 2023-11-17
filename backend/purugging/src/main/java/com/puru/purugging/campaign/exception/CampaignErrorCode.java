package com.puru.purugging.campaign.exception;


import com.puru.purugging.common.exception.ErrorCode;
import lombok.Getter;

@Getter
public enum CampaignErrorCode implements ErrorCode {

    NOT_FOUND_CAMPAIGN("해당 캠페인을 찾을 수 없습니다", "CMP_001", 404),
    EXCEEDED_THE_CAPACITY("더 이상 캠페인에 참여할 수 없습니다(정원 초과)", "CMP_002", 403), // HTTP 403 - Forbidden : 클라이언트의 요청이 서버에서 거부(클라이언트가 서버의 정책, 권한 또는 제한을 어겼을 때 사용)
    NOT_ORGANIZER("현재 유저는 캠페인의 주최자가 아닙니다.", "CMP_003", 403),
    NOT_FOUND_ATTENDANCE("해당 참여 정보를 찾을 수 없습니다", "CMP_004", 404),
    ZERO_OR_NEGATIVE_CAPACITY("현재 정원이 0 이하일 수 없습니다", "CMP_005", 403);

    private final String message;
    private final String errorCode;
    private final int statusCode;

    CampaignErrorCode(String message, String errorCode, int statusCode) {
        this.message = message;
        this.errorCode = errorCode;
        this.statusCode = statusCode;
    }
}
