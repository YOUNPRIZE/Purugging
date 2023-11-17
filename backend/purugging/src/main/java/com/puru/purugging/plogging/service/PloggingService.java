package com.puru.purugging.plogging.service;

import com.puru.purugging.global.storage.S3Uploader;
import com.puru.purugging.global.vo.Image;
import com.puru.purugging.machine.entity.Machine;
import com.puru.purugging.machine.exception.MachineErrorCode;
import com.puru.purugging.machine.exception.MachineException;
import com.puru.purugging.machine.repository.MachineRepository;
import com.puru.purugging.plogging.dto.PloggingPathSaveRequestDto;
import com.puru.purugging.plogging.dto.PloggingPathViewResponseDto;
import com.puru.purugging.plogging.entity.*;
import com.puru.purugging.plogging.entity.Plogging.PloggingStatus;
import com.puru.purugging.plogging.exception.PloggingErrorcode;
import com.puru.purugging.plogging.exception.PloggingException;
import com.puru.purugging.plogging.repository.PathRepository;
import com.puru.purugging.plogging.repository.PloggingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.geo.Point;
import org.springframework.data.mongodb.core.geo.GeoJsonLineString;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class PloggingService {

    private final PloggingRepository ploggingRepository;
    private final MachineRepository machineRepository;
    private final S3Uploader s3Uploader;
    private final PathRepository pathRepository;

    private final String PLOGGING_S3_DIRNAME = "PLOGGING";
//    private final IMqttAsyncClient mqttAsyncClient;

    //플로깅 시작
    public Plogging initiatePlogging(Plogging plogging, Long startMachineId) {

        //플로깅 상태 검증
        Plogging statusVerifiedPlogging = canInitiatePlogging(plogging);
        //플로깅 상태 변경
        Plogging statusChangedPlogging = changePloggingStatus(statusVerifiedPlogging);
        //플로깅 시작 정보 추가
        statusChangedPlogging.setStartMachineId(startMachineId);

        Plogging result = ploggingRepository.save(statusChangedPlogging);
        //봉투 개수 감소
        Machine findMachine = findVerifiedMachineById(startMachineId);
        findMachine.setBagCapacity(findMachine.getBagCapacity()-1);
        machineRepository.save(findMachine);

        return result;
    }

    private Machine findVerifiedMachineById(Long startMachineId) {
        return machineRepository.findById(startMachineId).orElseThrow(
                () -> new MachineException(MachineErrorCode.NOT_FOUND_MACHINE)
        );
    }

    //플로깅 종료
    public Plogging terminatePlogging(Plogging plogging, Long distance, Long endMachineId) {

        //플로깅 검증 조회
        Plogging findPlogging = findVerifiedPloggingByMemberId(plogging.getMemberId());
        //플로깅 상태 검증
        Plogging statusVerifiedPlogging = canTerminatePlogging(findPlogging);
        //플로깅 상태 변경
        Plogging statusChangedPlogging = changePloggingStatus(statusVerifiedPlogging);
        //플로깅 종료 정보 추가
        Plogging setPlogging = setEndInfo(statusChangedPlogging, distance, endMachineId);

        Plogging result = ploggingRepository.save(setPlogging);
        return result;
    }

    public Plogging closePendingPlogging(Plogging plogging) {

        //플로깅 검증 조회
        Plogging findPlogging = findVerifiedPloggingByMemberId(plogging.getMemberId());
        //플로깅 상태 검증
        Plogging statusVerifiedPlogging = canPendingClosurePlogging(findPlogging);
        //플로깅 상태 변경
        Plogging statusChangedPlogging = changePloggingStatus(statusVerifiedPlogging);

        Plogging result = ploggingRepository.save(statusChangedPlogging);
        return result;
    }

    //플로깅 업데이트
    public Plogging updatePlogging(Plogging plogging, Plogging request) {

        //플로깅 검증 조회
        Plogging findPlogging = findVerifiedPloggingByMemberId(plogging.getMemberId());
        //플로깅 상태 검증
        Plogging statusVerifiedPlogging = canUpdatePlogging(findPlogging);
        //플로깅 종료 정보 추가
        Plogging setPlogging = setUpdateInfo(statusVerifiedPlogging, request);

        Plogging result = ploggingRepository.save(setPlogging);
        return result;
    }

    //플로깅 이미지 업데이트
    public void updatePloggingImage(Long memberId, MultipartFile file) {

        // 사용자 최신 플로깅 불러오기(검증, 조회)
        Plogging findPlogging = findVerifiedPloggingByMemberId(memberId);

        //플로깅 상태 검증
        isCompletedPlogging(findPlogging);

        // 플로깅 이미지가 존재하면 에러 발생
        if (findPlogging.getPloggingImage() != null) {
            throw new PloggingException(PloggingErrorcode.PLOGGING_IMAGE_EXISTS);
        }

        // 프로필 사진 업데이트
        final Image image = s3Uploader.uploadImage(file, PLOGGING_S3_DIRNAME);
        findPlogging.setPloggingImage(image);

        // 업데이트된 사용자 정보 저장
        ploggingRepository.save(findPlogging);
    }

    //플로깅 상세 조회
    public Plogging findPlogging(Long ploggingId) {

        Plogging findPlogging = findVerifiedPloggingById(ploggingId);

        //조회 가능 여부 검증
        isCompletedPlogging(findPlogging);

        return findPlogging;
    }

    //플로깅 상태 조회
    public PloggingStatusInfo findPloggingStatus(Long memberId) {
        return ploggingRepository.findStatusByMemberId(memberId, PageRequest.of(0, 1)).orElse(null);
    }

    //플로깅 전체 조회
    public Page<Plogging> findAllPlogging(Long memberId, int page, int size) {

        return makePloggingPage(memberId, page, size);
    }

    //내부 메서드: 플로깅 id를 통한 플로깅 검증 조회
    private Plogging findVerifiedPloggingById(Long ploggingId) {
        return ploggingRepository.findById(ploggingId).orElseThrow(
                () -> new PloggingException(PloggingErrorcode.NOT_FOUND_PLOGGING)
        );
    }

    //내부 메서드: 유저 id를 통한 플로깅 검증 조회
    private Plogging findVerifiedPloggingByMemberId(Long memberId) {

        return ploggingRepository.findTopByMemberIdOrderByCreateDateDesc(memberId).orElseThrow(
                () -> new PloggingException(PloggingErrorcode.NOT_FOUND_PLOGGING)
        );
    }

    //내부 메서드: 플로깅 조회 가능 여부 확인
    private void isCompletedPlogging(Plogging findPlogging) {

        //플로깅 COMPLETED 상태만 조회 가능
        if (!findPlogging.getPloggingStatus().equals(PloggingStatus.PLOGGING_COMPLETED)) {
            throw new PloggingException(PloggingErrorcode.CANNOT_FIND_PLOGGING);
        }
    }

    //내부 메서드: 플로깅 시작 가능 여부 확인
    private Plogging canInitiatePlogging(Plogging plogging) {
        //현재 유저의 최신 Plogging이 PLOGGING_INCOMPLETE 상태이거나, plogging 자체가 없는 경우(null)에만 가능
        PloggingStatusInfo ploggingStatus = findPloggingStatus(plogging.getMemberId());

        if (ploggingStatus == null || ploggingStatus.getPloggingStatus()
                                                    .equals(PloggingStatus.PLOGGING_COMPLETED)) {
            return plogging;
        }
        throw new PloggingException(PloggingErrorcode.CANNOT_PROCEED_PLOGGING);
    }

    //내부 메서드: 플로깅 종료 가능 여부 확인
    private Plogging canTerminatePlogging(Plogging findPlogging) {
        //현재 유저의 최신 Plogging이 PLOGGOGING_IN_PROGRESS 상태인 경우에만 가능
        PloggingStatusInfo ploggingStatus = findPloggingStatus(findPlogging.getMemberId());

        if (ploggingStatus == null) {
            throw new PloggingException(PloggingErrorcode.CANNOT_PROCEED_PLOGGING);
        } else if (ploggingStatus.getPloggingStatus()
                                 .equals(PloggingStatus.PLOGGOGING_IN_PROGRESS)) {
            return findPlogging;
        }
        throw new PloggingException(PloggingErrorcode.CANNOT_PROCEED_PLOGGING);
    }

    //내부 메서드: 플로깅 업데이트 가능 여부 확인
    private Plogging canPendingClosurePlogging(Plogging findPlogging) {
        //현재 유저의 최신 Plogging이 PLOGGIGNG_PENDING_COMPLETION 상태인 경우에만 가능
        PloggingStatusInfo ploggingStatus = findPloggingStatus(findPlogging.getMemberId());

        if (ploggingStatus == null) {
            throw new PloggingException(PloggingErrorcode.CANNOT_PROCEED_PLOGGING);
        } else if (ploggingStatus.getPloggingStatus()
                                 .equals(PloggingStatus.PLOGGIGNG_PENDING_COMPLETION)) {
            return findPlogging;
        }
        throw new PloggingException(PloggingErrorcode.CANNOT_PROCEED_PLOGGING);
    }

    //내부 메서드: 플로깅 업데이트 가능 여부 확인
    private Plogging canUpdatePlogging(Plogging findPlogging) {
        //현재 유저의 최신 Plogging이 PLOGGIGNG_PENDING_COMPLETION 상태인 경우에만 가능
        PloggingStatusInfo ploggingStatus = findPloggingStatus(findPlogging.getMemberId());

        if (ploggingStatus == null) {
            throw new PloggingException(PloggingErrorcode.CANNOT_PROCEED_PLOGGING);
        } else if (ploggingStatus.getPloggingStatus()
                                 .equals(PloggingStatus.PLOGGING_COMPLETED)) {
            return findPlogging;
        }
        throw new PloggingException(PloggingErrorcode.CANNOT_PROCEED_PLOGGING);
    }

    //내부 메서드: 플로깅 상태 변경
    private Plogging changePloggingStatus(Plogging statusVerifiedPlogging) {

        if (statusVerifiedPlogging.getPloggingStatus().equals(PloggingStatus.PLOGGING_INCOMPLETE)) {
            statusVerifiedPlogging.setPloggingStatus(PloggingStatus.PLOGGOGING_IN_PROGRESS);
        } else if (statusVerifiedPlogging.getPloggingStatus()
                                         .equals(PloggingStatus.PLOGGOGING_IN_PROGRESS)) {
            statusVerifiedPlogging.setPloggingStatus(PloggingStatus.PLOGGIGNG_PENDING_COMPLETION);
        } else if (statusVerifiedPlogging.getPloggingStatus()
                                         .equals(PloggingStatus.PLOGGIGNG_PENDING_COMPLETION)) {
            statusVerifiedPlogging.setPloggingStatus(PloggingStatus.PLOGGING_COMPLETED);
        }

        return statusVerifiedPlogging;
    }

    //내무 메서드: 플로깅 종료 정보 업데이트
    private Plogging setEndInfo(Plogging statusChangedPlogging, Long distance, Long endMachineId) {

        statusChangedPlogging.setDistance(distance);
        statusChangedPlogging.setEndMachineId(endMachineId);

        return statusChangedPlogging;
    }

    //내무 메서드: 플로깅 업데이트 정보 업데이트
    private Plogging setUpdateInfo(Plogging statusChangedPlogging, Plogging request) {

        //일반 쓰레기 무게
        statusChangedPlogging.setGeneralTrashWeight(request.getGeneralTrashWeight());
        //페트 개수
        statusChangedPlogging.setPetCount(request.getPetCount());
        //캔 개수
        statusChangedPlogging.setCanCount(request.getCanCount());

        return statusChangedPlogging;
    }

    //내부 메서드: 플로깅 전체 조회 페이지 생성
    private Page<Plogging> makePloggingPage(Long memberId, int page, int size) {
        Page<Plogging> result = ploggingRepository.findAllByMemberId(memberId,
                PageRequest.of(page, size, Sort.by("id").descending()));
//        if(result.isEmpty()) throw new PloggingException(PloggingErrorcode.NOT_FOUND_CONTENTS);

        return result;
    }

//    public void savePloggingPath(Long ploggingId, PloggingPathSaveRequestDto ploggingPathSaveRequestDto) {
    public void savePloggingPath(Plogging plogging, PloggingPathSaveRequestDto ploggingPathSaveRequestDto) {
        // Convert coordinates to GeoJsonLineString
        List<Point> Points = ploggingPathSaveRequestDto.getGeometry().getCoordinates().stream()
                .map(point -> new GeoJsonPoint(point.getX(), point.getY()))
                .collect(Collectors.toList());

        GeoJsonLineString lineString = new GeoJsonLineString(Points);

        // Convert start and end time strings to Instant
        Instant startTime = Instant.parse(ploggingPathSaveRequestDto.getProperties().getStartTime());
        Instant endTime = Instant.parse(ploggingPathSaveRequestDto.getProperties().getEndTime());

        Plogging findPlogging = findVerifiedPloggingByMemberId(plogging.getMemberId());


        // Create the plogging path entity
        PathDocument ploggingPath = new PathDocument();
//        ploggingPath.setPloggingId(ploggingId);
        ploggingPath.setPloggingId(findPlogging.getId());
        ploggingPath.setGeometry(lineString);
        ploggingPath.setStartTime(startTime.toString());
        ploggingPath.setEndTime(endTime.toString());

        // Save the plogging path entity to MongoDB
        pathRepository.save(ploggingPath);
    }

    public PloggingPathViewResponseDto getPloggingPath(Long ploggingId) {
        PathDocument pathDocument = pathRepository.findByPloggingId(ploggingId);

        return new PloggingPathViewResponseDto(pathDocument);
    }
}
