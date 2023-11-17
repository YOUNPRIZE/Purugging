package com.puru.purugging.campaign.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.campaign.entity.Attendance;
import com.puru.purugging.common.pagination.MultiResponseDto;
import java.util.List;
import lombok.Builder;
import lombok.Getter;
import org.springframework.data.domain.Page;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class AttendanceListResponseDto extends MultiResponseDto<AttendanceDetailsResponseDto> {

    @Builder
    public AttendanceListResponseDto(List<AttendanceDetailsResponseDto> contents,
            Page page) {
        super(contents, page);
    }

    public static AttendanceListResponseDto from(List<AttendanceDetailsResponseDto> result,
            Page<Attendance> pageResult) {

        return AttendanceListResponseDto.builder().contents(result)
                                        .page(pageResult)
                                        .build();

    }
}
