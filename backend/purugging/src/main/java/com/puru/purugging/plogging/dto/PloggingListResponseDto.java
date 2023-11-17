package com.puru.purugging.plogging.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.common.pagination.MultiResponseDto;
import com.puru.purugging.plogging.entity.Plogging;
import java.util.List;
import lombok.Builder;
import lombok.Getter;
import org.springframework.data.domain.Page;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class PloggingListResponseDto extends MultiResponseDto<PloggingDetailsResponseDto> {

    @Builder
    public PloggingListResponseDto(List<PloggingDetailsResponseDto> contents,
            Page page) {
        super(contents, page);
    }

    public static PloggingListResponseDto from(List<PloggingDetailsResponseDto> result,
            Page<Plogging> pageResult) {
        return PloggingListResponseDto.builder()
                                      .contents(result)
                                      .page(pageResult)
                                      .build();
    }
}