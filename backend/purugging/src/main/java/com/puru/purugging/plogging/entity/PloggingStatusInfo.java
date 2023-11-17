package com.puru.purugging.plogging.entity;

import com.puru.purugging.plogging.entity.Plogging.PloggingStatus;
import lombok.Getter;

@Getter
public class PloggingStatusInfo {

    private Long ploggingId;
    private Long memberId;
    private Plogging.PloggingStatus ploggingStatus;

    public PloggingStatusInfo(Long ploggingId, Long memberId, PloggingStatus ploggingStatus) {
        this.ploggingId = ploggingId;
        this.memberId = memberId;
        this.ploggingStatus = ploggingStatus;
    }
}
