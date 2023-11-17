package com.puru.purugging.campaign.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.campaign.entity.Campaign;
import com.puru.purugging.common.pagination.MultiResponseDto;
import java.util.List;
import lombok.Builder;
import lombok.Getter;
import org.springframework.data.domain.Page;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class CampaignListResponseDto extends MultiResponseDto<CampaignDetailsResponseDto> {

    @Builder
    public CampaignListResponseDto(List<CampaignDetailsResponseDto> contents,
            Page page) {
        super(contents, page);
    }

    public static CampaignListResponseDto from(List<CampaignDetailsResponseDto> result,
            Page<Campaign> pageResult) {
        return CampaignListResponseDto.builder()
                                      .contents(result)
                                      .page(pageResult)
                                      .build();
    }
}
