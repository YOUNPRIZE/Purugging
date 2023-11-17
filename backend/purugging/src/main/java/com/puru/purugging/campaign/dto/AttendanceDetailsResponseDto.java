package com.puru.purugging.campaign.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.campaign.entity.Attendance;
import com.puru.purugging.campaign.entity.Attendance.AttendanceStatus;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class AttendanceDetailsResponseDto {

    private Long memberId;
    private AttendanceStatus attendanceStatus;

    @Builder
    public AttendanceDetailsResponseDto(Long memberId, AttendanceStatus attendanceStatus) {
        this.memberId = memberId;
        this.attendanceStatus = attendanceStatus;
    }

    public static AttendanceDetailsResponseDto from(Attendance attendance) {
        return AttendanceDetailsResponseDto.builder()
                                           .memberId(attendance.getMemberId())
                                           .attendanceStatus(attendance.getAttendanceStatus())
                                           .build();
    }
}
