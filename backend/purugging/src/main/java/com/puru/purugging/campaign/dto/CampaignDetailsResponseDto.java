package com.puru.purugging.campaign.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.campaign.entity.Campaign;
import com.puru.purugging.campaign.entity.Campaign.CampaignStatus;
import java.time.LocalDateTime;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class CampaignDetailsResponseDto {

    private Long id;
    private String title;
    private String content;
    private Long writerId;
    private LocalDateTime date;
    private Long maxParticipantNumber;
    private Long currentParticipantNumber;
    private CampaignStatus campaignStatus;

    @Builder
    public CampaignDetailsResponseDto(Long id, String title, String content, Long writerId,
            LocalDateTime date,
            Long maxParticipantNumber, Long currentParticipantNumber,
            CampaignStatus campaignStatus) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.writerId = writerId;
        this.date = date;
        this.maxParticipantNumber = maxParticipantNumber;
        this.currentParticipantNumber = currentParticipantNumber;
        this.campaignStatus = campaignStatus;
    }

    public static CampaignDetailsResponseDto from(Campaign result) {
        return CampaignDetailsResponseDto.builder()
                                         .id(result.getId())
                                         .title(result.getTitle())
                                         .content(result.getContent())
                                         .writerId(result.getMemberId())
                                         .date(result.getDate())
                                         .maxParticipantNumber(result.getMaxParticipantNumber())
                                         .currentParticipantNumber(
                                                 result.getCurrentParticipantNumber())
                                         .campaignStatus(result.getCampaignStatus())
                                         .build();
    }
}
