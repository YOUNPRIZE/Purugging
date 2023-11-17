package com.puru.purugging.notification.service;

import com.puru.purugging.campaign.dto.CampaignCreationRequestDto;
import com.puru.purugging.member.entity.Member;
import com.puru.purugging.member.repository.MemberRepository;
import com.puru.purugging.notification.entity.Notification;
import com.puru.purugging.notification.entity.Receive;
import com.puru.purugging.notification.exception.NotificationErrorCode;
import com.puru.purugging.notification.exception.NotificationException;
import com.puru.purugging.notification.repository.NotificationRepository;
import com.puru.purugging.notification.repository.ReceiveRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
@Transactional(readOnly = true)
@EnableScheduling
public class NotificationService {

    private final ReceiveRepository receiveRepository;
    private final NotificationRepository notificationRepository;
    private final MemberRepository memberRepository;

    // 알림 생성
    @Transactional
    public void createNotification(Notification notification) {
        notificationRepository.save(notification);
    }

    // 알림 삭제
    @Transactional
    public void deleteNotification(Long notiId) {
        Notification notification = findVerifiedNotification(notiId);
        notificationRepository.delete(notification);
    }

    // 알림 검증
    private Notification findVerifiedNotification(Long notiId) {
        return notificationRepository.findById(notiId).orElseThrow(
                () -> new NotificationException(NotificationErrorCode.NOT_FOUND_NOTIFICATION)
        );
    }

    // 알림 확인 생성
    @Transactional
    public void createReceive(Receive receive) {
        receiveRepository.save(receive);
    }

    // 알림 확인 삭제
    @Transactional
    public void deleteReceive(Long receiveId) {
        Receive receive = findVerifiedReceive(receiveId);
        receiveRepository.delete(receive);
    }

    // CHECKED -> UNCHECKED
    @Transactional
    public Receive checkReceive(Long receiveId) {
        Receive receive = findVerifiedReceive(receiveId);

        receive.setStatus(Receive.ReceiveStatus.RECEIVE_CHECKED);

        return receiveRepository.save(receive);
    }

    // Receive 상세 조회
    public Receive findReceive(Long receiveId) {
        return findVerifiedReceive(receiveId);
    }

    // 사용자별 Receive 조회
    public Page<Receive> findAllReceiveByMemberId(Long memberId, int page, int size) {
        return makeReceivePage(memberId, page, size);
    }

    private Page<Receive> makeReceivePage(Long memberId, int page, int size) {
        return receiveRepository.findAllByMemberId(memberId,
                PageRequest.of(page, size, Sort.by("id")));
    }

    // 알림 확인 검증
    private Receive findVerifiedReceive(Long receiveId) {
        return receiveRepository.findById(receiveId).orElseThrow(
                () -> new NotificationException(NotificationErrorCode.NOT_FOUND_RECEIVE)
        );
    }

    @Transactional
    public void createNotificationaAndReceiveByCreatingCampaign(CampaignCreationRequestDto dto) {
        Notification notification = Notification.builder()
                .title(dto.getTitle())
                .content(dto.getContent())
                .build();

        notificationRepository.save(notification);

        Long notiId = notification.getId();

        List<Member> members = memberRepository.findAll();

        for (Member member : members) {
            Receive receive = Receive.builder()
                    .memberId(member.getId())
                    .notiId(notiId)
                    .status(Receive.ReceiveStatus.RECEIVE_UNCHECKED)
                    .build();

            receiveRepository.save(receive);
        }
    }
}
