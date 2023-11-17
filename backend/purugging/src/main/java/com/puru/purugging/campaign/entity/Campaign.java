package com.puru.purugging.campaign.entity;

import com.puru.purugging.common.model.BaseTimeEntity;
import java.time.LocalDateTime;
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
public class Campaign extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "campaign_id")
    private Long id;

    @Column(name = "member_id")
    private Long memberId;

    @Setter
    @Column
    private String title;

    @Setter
    @Column
    private String content;

    @Setter
    @Column
    private LocalDateTime date;

    @Setter
    @Column(name = "max_participant_number")
    private Long maxParticipantNumber;

    @Setter
    @Column(name = "current_participant_number")
    private Long currentParticipantNumber; //기본값 설정

    @Setter
    @Column
    @Enumerated(EnumType.STRING)
    private CampaignStatus campaignStatus = CampaignStatus.CAMPAIGN_ACTIVE;

    @Builder
    public Campaign(Long id, Long memberId, String title, String content, LocalDateTime date,
            Long maxParticipantNumber, Long currentParticipantNumber) {
        this.id = id;
        this.memberId = memberId;
        this.title = title;
        this.content = content;
        this.date = date;
        this.maxParticipantNumber = maxParticipantNumber;
        this.currentParticipantNumber = currentParticipantNumber;
    }

    public enum CampaignStatus {
        CAMPAIGN_ACTIVE("캠페인 활성화 상태"),
        CAMPAIGN_INACTIVE("캠페인 비활성화 상태");

        @Getter
        private String status;

        CampaignStatus(String status) {
            this.status = status;
        }
    }
}
