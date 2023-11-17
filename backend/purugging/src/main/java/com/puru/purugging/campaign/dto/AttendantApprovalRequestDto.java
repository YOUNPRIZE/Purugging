package com.puru.purugging.campaign.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.campaign.entity.Attendance;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class AttendantApprovalRequestDto {

    private Long attendantId;
    private Long campaignId;

    @Builder
    public AttendantApprovalRequestDto(Long attendantId, Long campaignId) {
        this.attendantId = attendantId;
        this.campaignId = campaignId;
    }

    public static Attendance to(AttendantApprovalRequestDto request) {
        return Attendance.builder()
                .memberId(request.getAttendantId())
                .campaignId(request.getCampaignId())
                .build();
    }
}
