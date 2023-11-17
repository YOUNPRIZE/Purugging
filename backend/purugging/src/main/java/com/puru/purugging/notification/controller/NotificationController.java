package com.puru.purugging.notification.controller;

import com.puru.purugging.common.response.ResponseFactory;
import com.puru.purugging.notification.dto.FCMTokenRequestDto;
import com.puru.purugging.notification.dto.NotificationCreationRequestDto;
import com.puru.purugging.notification.dto.ReceiveDetailsResponseDto;
import com.puru.purugging.notification.dto.ReceiveListResponseDto;
import com.puru.purugging.notification.entity.Receive;
import com.puru.purugging.notification.service.FCMService;
import com.puru.purugging.notification.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.apache.coyote.Response;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Positive;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/notifications")
public class NotificationController {
    private final FCMService fcmService;
    private final NotificationService notificationService;

    // token 저장
    @PostMapping("/saveTokens")
    public ResponseEntity<?> saveToken(@RequestBody FCMTokenRequestDto dto) {
        fcmService.saveFirebaseToken(dto);
        return ResponseFactory.success("토큰 저장 성공");
    }

    // 사용자별 알림 확인 전체 조회
    @GetMapping("/{member-id}")
    public ResponseEntity<?> receiveListByMember(@PathVariable("member-id") Long memberId, @Positive @RequestParam int page, @Positive @RequestParam int size) {
        Page<Receive> pageResult = notificationService.findAllReceiveByMemberId(memberId, page - 1, size);
        List<Receive> receiveList = pageResult.getContent();
        List<ReceiveDetailsResponseDto> result = receiveList.stream()
                .map(ReceiveDetailsResponseDto::from)
                .collect(Collectors.toList());

        return ResponseFactory.success("알림 확인 전체 조회 성공",
                ReceiveListResponseDto.from(result, pageResult));
    }

    // 알림 확인 상세 조회
    @GetMapping("/detail/{receive-id}")
    public ResponseEntity<?> receiveDetails(@PathVariable("receive-id") Long receiveId) {
        Receive result = notificationService.findReceive(receiveId);

        return ResponseFactory.success("알림 확인 상세 조회 성공", result);
    }

    // 알림 확인 읽음 처리
    @PatchMapping("/status/{receive-id}")
    public ResponseEntity<?> receiveCheck(@PathVariable("receive-id") Long receiveId) {
        Receive result = notificationService.checkReceive(receiveId);
        return ResponseFactory.success("알림 확인 읽음 처리 성공", result);
    }

    // 알림 생성
    @PostMapping
    public ResponseEntity<?> createNotification(@RequestBody NotificationCreationRequestDto request) {
        notificationService.createNotification(NotificationCreationRequestDto.to(request));
        return ResponseFactory.success("알림 생성 성공");
    }

    // 알림 삭제
    @DeleteMapping("/{noti-id}")
    public ResponseEntity<?> deleteNotification(@PathVariable("noti-id") Long notiId) {
        notificationService.deleteNotification(notiId);
        return ResponseFactory.success("알림 삭제 성공");
    }

//    // 알림 전송
//    @PostMapping
//    public ResponseEntity<?> sendFCMToken(@RequestBody FCMRequestDto dto) throws FirebaseMessagingException {
//        fcmService.sendNotificationByToken(dto);
//        return ResponseFactory.success("알림 전송 성공");
//    }
}
