package com.puru.purugging.plogging.entity;

import com.puru.purugging.common.model.BaseTimeEntity;
import com.puru.purugging.global.vo.Image;
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Embedded;
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
public class Plogging extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "plogging_id")
    private Long id;

    @Column(name = "member_id")
    private Long memberId;

    @Setter
    @Column(name = "start_machine_id")
    private Long startMachineId;

    @Setter
    @Column(name = "end_machine_id")
    private Long endMachineId;

    @Setter
    @Column(name = "distance")
    private Long distance;

    @Setter
    @Column(name = "general_trash_weight")
    private Double generalTrashWeight;

    @Setter
    @Column(name = "pet_count")
    private Long petCount;

    @Setter
    @Column(name = "can_count")
    private Long canCount;

    @Setter
    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "imageUrl", column = @Column(name = "profile_image_url")),
            @AttributeOverride(name = "imageType", column = @Column(name = "profile_image_type")),
            @AttributeOverride(name = "imageName", column = @Column(name = "profile_image_name")),
            @AttributeOverride(name = "imageUUID", column = @Column(name = "profile_image_uuid"))
    })
    private Image ploggingImage;

    @Setter
    @Column
    @Enumerated(EnumType.STRING)
    private PloggingStatus ploggingStatus = PloggingStatus.PLOGGING_INCOMPLETE; //생성 초기 기본값(미진행 상태)

    @Builder
    public Plogging(Long id, Long memberId, Long startMachineId, Long endMachineId, Long distance,
            Double generalTrashWeight, Long petCount, Long canCount) {
        this.id = id;
        this.memberId = memberId;
        this.startMachineId = startMachineId;
        this.endMachineId = endMachineId;
        this.distance = distance;
        this.generalTrashWeight = generalTrashWeight;
        this.petCount = petCount;
        this.canCount = canCount;
    }

    public enum PloggingStatus {
        PLOGGING_INCOMPLETE("플로깅 미진행 상태"),
        PLOGGOGING_IN_PROGRESS("플로깅 진행중 상태"),
        PLOGGIGNG_PENDING_COMPLETION("플로깅 종료 대기 상태"),
        PLOGGING_COMPLETED("플로깅 완료 상태");

        @Getter
        private String status;

        PloggingStatus(String status) {
            this.status = status;
        }
    }

    public static Plogging to(Long memberId) {
        return Plogging.builder()
                       .memberId(memberId)
                       .build();
    }
}
