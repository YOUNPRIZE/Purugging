package com.puru.purugging.campaign.exception;

import com.puru.purugging.common.exception.CustomException;
import com.puru.purugging.common.exception.ErrorCode;

public class CampaignException extends CustomException {

    public CampaignException(String message, ErrorCode errorCode) {
        super(message, errorCode);
    }

    public CampaignException(ErrorCode errorCode) {
        super(errorCode);
    }
}
