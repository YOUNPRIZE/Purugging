package com.puru.purugging.notification.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.puru.purugging.campaign.dto.CampaignCreationRequestDto;
import com.puru.purugging.campaign.entity.Campaign;
import com.puru.purugging.campaign.repository.CampaignRepository;
import com.puru.purugging.notification.dto.FCMSendRequestDto;
import com.puru.purugging.notification.dto.FCMTokenRequestDto;
import com.puru.purugging.notification.entity.FCMToken;
import com.puru.purugging.notification.repository.FCMRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
@Transactional(readOnly = true)
@EnableScheduling
public class FCMService {
    private final FirebaseMessaging firebaseMessaging;
    private final FCMRepository fcmRepository;
    private final CampaignRepository campaignRepository;

    /*
     * 1. token 저장
     * 2. Client에서 알림 전송을 요청하는 경우
     * 3. 캠페인 생성 시, 전체 사용자에게 알림 전송
     * 4. D - 3 이고, CampaignStatus 가 Active인 캠페인, 전체 사용자에게 알림 전송
     * */

    @Transactional
    public void saveFirebaseToken(FCMTokenRequestDto dto) {
        Optional<FCMToken> fcmToken = fcmRepository.findByFirebaseToken(dto.getFCMToken());

        if (!fcmToken.isPresent()) {
            FCMToken token = FCMToken.builder()
                    .memberId(dto.getMemberId())
                    .firebaseToken(dto.getFCMToken())
                    .build();
            fcmRepository.save(token);
        }
    }

    public void sendNotificationByToken(FCMSendRequestDto dto) throws FirebaseMessagingException {
        List<FCMToken> fcmTokens = fcmRepository.findByMemberId(dto.getUserId());

        for (FCMToken fcmToken : fcmTokens) {
            if (fcmToken.getFirebaseToken() != null) {
                Notification notification = Notification.builder()
                        .setTitle(dto.getTitle())
                        .setBody(dto.getBody())
                        .build();

                Message message = Message.builder()
                        .setToken(fcmToken.getFirebaseToken())
                        .setNotification(notification)
                        .build();

                try {
                    firebaseMessaging.send(message);
                } catch (FirebaseMessagingException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    public void sendNotificationByCreatingCampaign(CampaignCreationRequestDto dto) throws FirebaseMessagingException {
        List<FCMToken> fcmTokens = fcmRepository.findAll();
        for (FCMToken fcmToken : fcmTokens) {
            if (fcmToken.getFirebaseToken() != null) {
                Notification notification = Notification.builder()
                        .setTitle(dto.getTitle())
                        .setBody(dto.getContent())
                        .build();

                Message message = Message.builder()
                        .setToken(fcmToken.getFirebaseToken())
                        .setNotification(notification)
                        .build();

                try {
                    firebaseMessaging.send(message);
                } catch (FirebaseMessagingException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Scheduled(cron = "0 0 9 * * ?")
    public void sendNotificationForUpcomingCampaign() throws FirebaseMessagingException {
        // 1. 오늘 날짜 불러오기
        LocalDateTime currentDate = LocalDateTime.now();

        // 2. 오늘 날짜로부터 3일 후의 날짜 불러오기
        LocalDateTime threeDaysLater = currentDate.plusDays(3);

        // 3. 3일 후 아직 종료되지 않은 모든 캠페인 불러오기
        List<Campaign> campaigns = campaignRepository.findByDateAfterAndCampaignStatus(threeDaysLater, Campaign.CampaignStatus.CAMPAIGN_ACTIVE);

        // 4. 참여 인원이 최대 인원보다 적은 캠페인 필터링
        List<Campaign> joinableCampaigns = campaigns.stream()
                .filter(campaign -> campaign.getCurrentParticipantNumber() < campaign.getMaxParticipantNumber())
                .collect(Collectors.toList());

        if (joinableCampaigns != null) {
            // 5. 각 캠페인에 대해 알림 전송
            List<FCMToken> fcmTokens = fcmRepository.findAll();
            for (Campaign campaign : joinableCampaigns) {
                for (FCMToken fcmToken : fcmTokens) {
                    if (fcmToken.getFirebaseToken() != null) {
                        Notification notification = Notification.builder()
                                .setTitle("[D-3] " + campaign.getTitle())
                                .setBody("3일 전! 해당 캠페인에 참여해보세요!\n" + campaign.getContent())
                                .build();

                        Message message = Message.builder()
                                .setToken(fcmToken.getFirebaseToken())
                                .setNotification(notification)
                                .build();

                        try {
                            firebaseMessaging.send(message);
                        } catch (FirebaseMessagingException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
    }
}
