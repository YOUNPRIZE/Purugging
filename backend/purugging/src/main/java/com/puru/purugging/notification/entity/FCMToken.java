package com.puru.purugging.notification.entity;

import com.puru.purugging.common.model.BaseTimeEntity;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class FCMToken extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "fcmtoken_id")
    private Long id;

    private Long memberId;

    private String firebaseToken;

    @Builder
    public FCMToken(Long id, Long memberId, String firebaseToken) {
        this.id = id;
        this.memberId = memberId;
        this.firebaseToken = firebaseToken;
    }
}
