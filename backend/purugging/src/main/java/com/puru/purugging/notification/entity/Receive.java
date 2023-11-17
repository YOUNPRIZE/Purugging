package com.puru.purugging.notification.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class Receive {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "receive_id")
    private Long id;
    private Long memberId;
    private Long notiId;
    @Setter
    @Enumerated(EnumType.STRING)
    private ReceiveStatus status;

    public enum ReceiveStatus {
        RECEIVE_CHECKED("알림 확인 상태"),
        RECEIVE_UNCHECKED("알림 미확인 상태");

        @Getter
        private String status;

        ReceiveStatus(String status) {
            this.status = status;
        }
    }

    @Builder
    public Receive(Long id, Long memberId, Long notiId, ReceiveStatus status) {
        this.id = id;
        this.memberId = memberId;
        this.notiId = notiId;
        this.status = status;
    }
}
