package com.puru.purugging.campaign.service;

import com.puru.purugging.campaign.entity.Attendance;
import com.puru.purugging.campaign.entity.Attendance.AttendanceStatus;
import com.puru.purugging.campaign.entity.Campaign;
import com.puru.purugging.campaign.entity.Campaign.CampaignStatus;
import com.puru.purugging.campaign.exception.CampaignErrorCode;
import com.puru.purugging.campaign.exception.CampaignException;
import com.puru.purugging.campaign.repository.AttendanceRepository;
import com.puru.purugging.campaign.repository.CampaignRepository;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class CampaignService {

    private final CampaignRepository campaignRepository;
    private final AttendanceRepository attendanceRepository;

    //TODO. 캠페인 생성 제한 조건 필요
    public void createCampaign(Campaign campaign) {
        //캠페인 생성
        Campaign savedCampaign = campaignRepository.save(campaign);
        //본인이 참여한 참여 데이터 생성
        Attendance organizer = Attendance.from(savedCampaign.getMemberId(), savedCampaign.getId());
        organizer.setAttendanceStatus(AttendanceStatus.ATTENDANCE_IS_ORGANIZER);
        attendCampaign(organizer);
    }


    public Campaign findCampaign(Long campaignId) {

        return findVerifiedCampaign(campaignId);
    }

    private Campaign findVerifiedCampaign(Long campaignId) {
        return campaignRepository.findById(campaignId).orElseThrow(
                () -> new CampaignException(CampaignErrorCode.NOT_FOUND_CAMPAIGN)
        );
    }

    public Page<Campaign> findAllCampaign(int page, int size) {

        return makeCampaignPage(page, size);
    }

    public Page<Campaign> findAllCampaignByWriter(Long memberId, int page, int size) {

        return makeCampaignPageByWriter(memberId, page, size);
    }

    private Page<Campaign> makeCampaignPage(int page, int size) {

        return campaignRepository.findAllByCampaignStatus(CampaignStatus.CAMPAIGN_ACTIVE, PageRequest.of(page, size, Sort.by("id").descending()));
    }

    private Page<Campaign> makeCampaignPageByWriter(Long memberId, int page, int size) {

        return campaignRepository.findAllByMemberIdAndCampaignStatus(memberId, CampaignStatus.CAMPAIGN_ACTIVE, PageRequest.of(page, size, Sort.by("id").descending()));
    }

    public Campaign updateCampaign(Long campaignId, Campaign campaign) {
        Campaign findCampaign = findVerifiedCampaign(campaignId);

        Optional.ofNullable(campaign.getTitle())
                .ifPresent(findCampaign::setTitle);
        Optional.ofNullable(campaign.getContent())
                .ifPresent(findCampaign::setContent);
        Optional.ofNullable(campaign.getDate())
                .ifPresent(findCampaign::setDate);
        Optional.ofNullable(campaign.getMaxParticipantNumber())
                .ifPresent(findCampaign::setMaxParticipantNumber);

        return campaignRepository.save(findCampaign);
    }

    public void deleteCampaign(Long campaignId) {
        Campaign findCampaign = findVerifiedCampaign(campaignId);

        campaignRepository.save(changeCampaignStatus(findCampaign));
    }

    private Campaign changeCampaignStatus(Campaign findCampaign) {

        CampaignStatus findCampaignStatus = findCampaign.getCampaignStatus();

        if (findCampaignStatus == CampaignStatus.CAMPAIGN_ACTIVE) {
            findCampaign.setCampaignStatus(CampaignStatus.CAMPAIGN_INACTIVE);
        } else if (findCampaignStatus == CampaignStatus.CAMPAIGN_INACTIVE) {
            findCampaign.setCampaignStatus(CampaignStatus.CAMPAIGN_ACTIVE);
        }

        return findCampaign;
    }

    public void attendCampaign(Attendance attendance) {
        //참여 데이터 생성
        Attendance savedAttendance = attendanceRepository.save(attendance);
        //연관 캠페인 테이블 필드 변경
        plusCurrentParticipantNumber(savedAttendance);
    }

    private void plusCurrentParticipantNumber(Attendance savedAttendance) {
        //연관 캠페인 테이블 조회
        Campaign findCampaign = findVerifiedCampaign(savedAttendance.getCampaignId());
        Long currentParticipantNumber = findCampaign.getCurrentParticipantNumber();
        Long maxParticipantNumber = findCampaign.getMaxParticipantNumber();
        //최대 인원 초과 시 에러 발생
        if (currentParticipantNumber >= maxParticipantNumber) {
            throw new CampaignException(CampaignErrorCode.EXCEEDED_THE_CAPACITY);
        } else {
            findCampaign.setCurrentParticipantNumber(currentParticipantNumber + 1);
        }
    }

    public Page<Attendance> findAllAttendance(Long campaignId, int page, int size) {

        return makeAttendancePage(campaignId, page, size);
    }

    private Page<Attendance> makeAttendancePage(Long campaignId, int page, int size) {

        return attendanceRepository.findAllByCampaignId(campaignId,
                PageRequest.of(page, size, Sort.by("id")));
    }

    public void approveAttendant(Long memberId, Attendance attendance) {
        //주최자 검증
        if (!isOrganizer(memberId, attendance.getCampaignId())) {
            throw new CampaignException(CampaignErrorCode.NOT_ORGANIZER);
        }
        //참여자, 캠페인 검증 => member 검증은 Member 부분에서 참고
        findVerifiedCampaign(attendance.getCampaignId());
        //참여자 상태 변경
        Attendance changedAttendant = changeAttendantStatus(attendance);
        attendanceRepository.save(changedAttendant);
    }

    private Attendance changeAttendantStatus(Attendance attendance) {
        Attendance findAttendance = findVerifiedAttendanceByMemberIdAndCampaignId(attendance);

        AttendanceStatus findAttendanceStatus = findAttendance.getAttendanceStatus();

        if (findAttendanceStatus.equals(AttendanceStatus.ATTENDANCE_NOT_APPROVED)) {
            findAttendanceStatus = AttendanceStatus.ATTENDANCE_APPROVED;
        } else {
            findAttendanceStatus = AttendanceStatus.ATTENDANCE_NOT_APPROVED;
        }

        findAttendance.setAttendanceStatus(findAttendanceStatus);

        return findAttendance;
    }

    private Attendance findVerifiedAttendanceByMemberIdAndCampaignId(Attendance attendance) {

        return attendanceRepository.findByMemberIdAndCampaignId(attendance.getMemberId(),
                attendance.getCampaignId()).orElseThrow(
                () -> new CampaignException(CampaignErrorCode.NOT_FOUND_ATTENDANCE));
    }

    private boolean isOrganizer(Long memberId, Long campaignId) {
        return findVerifiedCampaign(campaignId).getMemberId().equals(memberId);
    }

    public void deleteAttendance(Long memberId, Long campaignId) {

        //참여 데이터 삭제
        attendanceRepository.deleteByMemberIdAndCampaignId(memberId, campaignId);

        //연관 캠페인 테이블 필드 변경
        minusCurrentParticipantNumber(campaignId);
    }

    private void minusCurrentParticipantNumber(Long campaignId) {
        //연관 캠페인 테이블 조회
        Campaign findCampaign = findVerifiedCampaign(campaignId);
        Long currentParticipantNumber = findCampaign.getCurrentParticipantNumber();
        //최대 인원 초과 시 에러 발생
        if (currentParticipantNumber <= 0) {
            throw new CampaignException(CampaignErrorCode.ZERO_OR_NEGATIVE_CAPACITY);
        } else {
            findCampaign.setCurrentParticipantNumber(currentParticipantNumber - 1);
        }
    }
}
