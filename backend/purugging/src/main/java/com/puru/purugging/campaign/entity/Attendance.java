package com.puru.purugging.campaign.entity;

import com.puru.purugging.common.model.BaseTimeEntity;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class Attendance extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "attendance_id")
    private Long id;

    @Column(name = "member_id")
    private Long memberId;

    @Column(name = "campaign_id")
    private Long campaignId;

    @Setter
    @Column
    @Enumerated(EnumType.STRING)
    private AttendanceStatus attendanceStatus = AttendanceStatus.ATTENDANCE_NOT_APPROVED;

    @Builder
    public Attendance(Long id, Long memberId, Long campaignId) {
        this.id = id;
        this.memberId = memberId;
        this.campaignId = campaignId;
    }

    public enum AttendanceStatus {
        ATTENDANCE_APPROVED("주최자 승인 상태"),
        ATTENDANCE_NOT_APPROVED("주최자 미승인 상태"),
        ATTENDANCE_IS_ORGANIZER("주최자 상태");

        @Getter
        private String status;

        AttendanceStatus(String status) {
            this.status = status;
        }
    }

    public static Attendance from(Long memberId, Long campaignId) {
        return Attendance.builder()
                         .memberId(memberId)
                         .campaignId(campaignId)
                         .build();
    }

}
