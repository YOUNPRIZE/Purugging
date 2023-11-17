package com.puru.purugging.notification.entity;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "noti_id")
    private Long id;
    private String title;
    private String content;

    @Builder
    public Notification(Long id, String title, String content) {
        this.id = id;
        this.title = title;
        this.content = content;
    }
}
