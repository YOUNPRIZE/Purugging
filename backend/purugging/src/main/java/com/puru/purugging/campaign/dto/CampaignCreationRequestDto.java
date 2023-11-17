package com.puru.purugging.campaign.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.campaign.entity.Campaign;
import java.time.LocalDateTime;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class CampaignCreationRequestDto {

    private String title;
    private String content;
    private LocalDateTime date;
    private Long maxParticipantNumber;

    @Builder
    public CampaignCreationRequestDto(String title, String content, LocalDateTime date,
            Long maxParticipantNumber) {
        this.title = title;
        this.content = content;
        this.date = date;
        this.maxParticipantNumber = maxParticipantNumber;
    }

    public static Campaign to(Long memberId, CampaignCreationRequestDto request) {
        return Campaign.builder()
                       .memberId(memberId)
                       .title(request.getTitle())
                       .content(request.getContent())
                       .date(request.getDate())
                       .maxParticipantNumber(request.getMaxParticipantNumber())
                       .currentParticipantNumber(0L)
                       .build();
    }
}
