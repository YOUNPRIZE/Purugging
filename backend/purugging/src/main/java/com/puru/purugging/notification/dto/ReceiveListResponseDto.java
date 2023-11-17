package com.puru.purugging.notification.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.common.pagination.MultiResponseDto;
import com.puru.purugging.notification.entity.Receive;
import lombok.Builder;
import lombok.Getter;
import org.springframework.data.domain.Page;

import java.util.List;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class ReceiveListResponseDto extends MultiResponseDto<ReceiveDetailsResponseDto> {

    @Builder
    public ReceiveListResponseDto(List<ReceiveDetailsResponseDto> contents, Page page) {
        super(contents, page);
    }

    public static ReceiveListResponseDto from(List<ReceiveDetailsResponseDto> result,
            Page<Receive> pageResult) {
        return ReceiveListResponseDto.builder()
                .contents(result)
                .page(pageResult)
                .build();
    }
}
