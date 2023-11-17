package com.puru.purugging.campaign.controller;

import com.google.firebase.messaging.FirebaseMessagingException;
import com.puru.purugging.campaign.dto.AttendanceDetailsResponseDto;
import com.puru.purugging.campaign.dto.AttendanceListResponseDto;
import com.puru.purugging.campaign.dto.AttendantApprovalRequestDto;
import com.puru.purugging.campaign.dto.CampaignCreationRequestDto;
import com.puru.purugging.campaign.dto.CampaignDetailsResponseDto;
import com.puru.purugging.campaign.dto.CampaignListResponseDto;
import com.puru.purugging.campaign.dto.CampaignModificationRequestDto;
import com.puru.purugging.campaign.entity.Attendance;
import com.puru.purugging.campaign.entity.Campaign;
import com.puru.purugging.campaign.service.CampaignService;
import com.puru.purugging.common.response.ResponseFactory;
import com.puru.purugging.member.service.MemberService;
import java.util.List;
import java.util.stream.Collectors;
import javax.validation.constraints.Positive;

import com.puru.purugging.notification.service.FCMService;
import com.puru.purugging.notification.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/campaigns")
@RequiredArgsConstructor
public class CampaignController {

    private final CampaignService campaignService;
    private final FCMService fcmService;
    private final NotificationService notificationService;
    private final MemberService memberService;

    //캠페인 생성
    @PostMapping
    public ResponseEntity<?> campaignCreation(@RequestParam Long memberId,
            @RequestBody CampaignCreationRequestDto request) throws FirebaseMessagingException {

        campaignService.createCampaign(CampaignCreationRequestDto.to(memberId, request));

        // 캠페인 생성될 때 알림이 생성되고 모든 사용자에게 알림 수신(RECEIVE)이 생성
        notificationService.createNotificationaAndReceiveByCreatingCampaign(request);
        // 그 후, FCM_TOKEN을 가지고 있는 모든 사용자에게 알림 송신
        fcmService.sendNotificationByCreatingCampaign(request);

        return ResponseFactory.success("캠페인 생성 성공");
    }

    //캠페인 상세 조회
    @GetMapping("/{campaign-id}")
    public ResponseEntity<?> campaignDetails(@PathVariable("campaign-id") Long campaignId) {

        Campaign result = campaignService.findCampaign(campaignId);

        return ResponseFactory.success("캠페인 상세조회 성공", CampaignDetailsResponseDto.from(result));
    }

    //캠페인 전체 조회
    @GetMapping
    public ResponseEntity<?> campaignList(@Positive @RequestParam int page,
            @Positive @RequestParam int size) {

        Page<Campaign> pageResult = campaignService.findAllCampaign(page - 1, size);
        List<Campaign> campaignList = pageResult.getContent();
        List<CampaignDetailsResponseDto> result = campaignList.stream()
                                                              .map(CampaignDetailsResponseDto::from)
                                                              .collect(Collectors.toList());

        return ResponseFactory.success("캠페인 전체조회 성공",
                CampaignListResponseDto.from(result, pageResult));
    }

    //캠페인 전체 조회
    @GetMapping("/writer")
    public ResponseEntity<?> campaignListByWriter(@Positive @RequestParam int page,
            @Positive @RequestParam int size, @RequestParam Long memberId) {

        Page<Campaign> pageResult = campaignService.findAllCampaignByWriter(memberId, page - 1, size);
        List<Campaign> campaignList = pageResult.getContent();
        List<CampaignDetailsResponseDto> result = campaignList.stream()
                                                              .map(CampaignDetailsResponseDto::from)
                                                              .collect(Collectors.toList());

        return ResponseFactory.success("캠페인 전체조회 성공",
                CampaignListResponseDto.from(result, pageResult));
    }

    //캠페인 수정
    @PatchMapping("/{campaign-id}")
    public ResponseEntity<?> campaignModification(@PathVariable("campaign-id") Long campaignId,
            @RequestBody CampaignModificationRequestDto request) {

        Campaign result = campaignService.updateCampaign(campaignId,
                CampaignModificationRequestDto.to(request));

        return ResponseFactory.success("캠페인 수정 성공", CampaignDetailsResponseDto.from(result));
    }

    //캠페인 삭제
    @DeleteMapping("/{campaign-id}")
    public ResponseEntity<?> campaignRemoval(@PathVariable("campaign-id") Long campaignId) {

        campaignService.deleteCampaign(campaignId);

        return ResponseFactory.success("캠페인 삭제 성공");
    }

    //캠페인 참여
    @PostMapping("/attendance/{campaign-id}")
    public ResponseEntity<?> campaignAttendance(@RequestParam Long memberId,
            @PathVariable("campaign-id") Long campaignId) {

        campaignService.attendCampaign(Attendance.from(memberId, campaignId));

        return ResponseFactory.success("캠페인 참석 성공");
    }

    //캠페인 참여 유저 목록 확인
    @GetMapping("/attendance/{campaign-id}")
    public ResponseEntity<?> attendanceList(@RequestParam Long memberId,
            @PathVariable("campaign-id") Long campaignId,
            @Positive @RequestParam int page,
            @Positive @RequestParam int size) {

        Page<Attendance> pageResult = campaignService.findAllAttendance(campaignId, page - 1, size);
        List<Attendance> attendanceList = pageResult.getContent();
        List<AttendanceDetailsResponseDto> result = attendanceList.stream()
                                                                  .map(AttendanceDetailsResponseDto::from)
                                                                  .collect(Collectors.toList());

        return ResponseFactory.success("캠페인 참여 유저 목록 조회 성공",
                AttendanceListResponseDto.from(result, pageResult));
    }

    //캠체인 참여 유저 승인
    @PatchMapping("/attendance/approval")
    public ResponseEntity<?> attendantApproval(@RequestParam Long memberId,
            @RequestBody AttendantApprovalRequestDto request) {
        campaignService.approveAttendant(memberId, AttendantApprovalRequestDto.to(request));
        memberService.updateMemberCampaignInfo(request.getAttendantId());

        return ResponseFactory.success("캠페인 참여 유저 상태 변경 성공");
    }

    //캠페인 참여 취소
    @DeleteMapping("/attendance/{campaign-id}")
    public ResponseEntity<?> attendanceRemoval(@RequestParam Long memberId,
            @PathVariable("campaign-id") Long campaignId) {

        campaignService.deleteAttendance(memberId, campaignId);

        return ResponseFactory.success("캠페인 참여 취소 성공");
    }
}