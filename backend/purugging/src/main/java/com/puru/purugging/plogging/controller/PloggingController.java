package com.puru.purugging.plogging.controller;

import com.puru.purugging.common.response.ResponseFactory;
import com.puru.purugging.member.service.MemberService;
import com.puru.purugging.plogging.dto.*;
import com.puru.purugging.plogging.entity.Plogging;
import com.puru.purugging.plogging.entity.PloggingStatusInfo;
import com.puru.purugging.plogging.service.PloggingService;
import java.util.List;
import java.util.stream.Collectors;
import javax.validation.constraints.Positive;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/ploggings")
@RequiredArgsConstructor
public class PloggingController {

    private final PloggingService ploggingService;
    private final MemberService memberService;

    //플로깅 시작하기(생성) - MQTT
    public Plogging ploggingInitiation(@RequestParam Long memberId,
            @RequestParam Long startMachineId) {

        return ploggingService.initiatePlogging(Plogging.to(memberId), startMachineId);

    }

    //플로깅 종료하기(상태 변경) - MQTT
    public Plogging ploggingTermination(@RequestParam Long memberId,
            @RequestParam Long endMachineId,
            @RequestParam Long distance) {

        return ploggingService.terminatePlogging(Plogging.to(memberId), distance, endMachineId);

    }

    //플로깅 대기 종료
    public Plogging ploggingPendingClosure(@RequestParam Long memberId){

        return ploggingService.closePendingPlogging(Plogging.to(memberId));

    }

    //플로깅 정보 업데이트(상태 변경) - MQTT
    @Transactional
    public Plogging ploggingUpdate(@RequestParam Long memberId,
            @RequestBody PloggingUpdateRequestDto request) {

        Plogging plogging = ploggingService.updatePlogging(Plogging.to(memberId), PloggingUpdateRequestDto.to(request));
        memberService.updateMemberPloggingInfo(memberId, PloggingUpdateRequestDto.to(request));

        return plogging;
    }

    //플로깅 상태 확인
    @GetMapping("/status")
    public ResponseEntity<?> ploggingStatus(@RequestParam Long memberId) {

        PloggingStatusInfo result = ploggingService.findPloggingStatus(memberId);

        return ResponseFactory.success("플로깅 상태 조회 성공", PloggingStatusResponseDto.from(result));
    }

    //플로깅 상세 조회
    @GetMapping("/{plogging-id}")
    public ResponseEntity<?> ploggingDetails(@PathVariable("plogging-id") Long ploggingId,
            @RequestParam Long memberId) {

        Plogging result = ploggingService.findPlogging(ploggingId);

        return ResponseFactory.success("플로깅 상세 조회 성공", PloggingDetailsResponseDto.from(result));
    }

    //개인 플로깅 히스토리 조회(전체 조회)
    @GetMapping("/list")
    public ResponseEntity<?> ploggingList(@RequestParam Long memberId,
            @Positive @RequestParam int page,
            @Positive @RequestParam int size) {

        Page<Plogging> pageResult = ploggingService.findAllPlogging(memberId, page - 1, size);
        List<Plogging> ploggingList = pageResult.getContent();
        List<PloggingDetailsResponseDto> result = ploggingList.stream()
                                                              .map(PloggingDetailsResponseDto::from)
                                                              .collect(Collectors.toList());

        return ResponseFactory.success("플로깅 전체조회 성공",
                PloggingListResponseDto.from(result, pageResult));
    }

    //플로깅 사진 등록 => 클라이언트 처리
    //플로깅 사진 업데이트
    @PatchMapping("/image")
    public ResponseEntity<?> ploggingImage(@RequestParam Long memberId,
            @RequestPart MultipartFile file) {
        ploggingService.updatePloggingImage(memberId, file);

        return ResponseFactory.success("플로깅 사진 업데이트 성공");
    }

    @PostMapping("/path")
//    public ResponseEntity<?> savePloggingPath(@RequestParam Long ploggingId,
//            @RequestBody PloggingPathSaveRequestDto ploggingPathSaveRequestDto) {
//        ploggingService.savePloggingPath(ploggingId, ploggingPathSaveRequestDto);
    public ResponseEntity<?> savePloggingPath(@RequestParam Long memberId,
              @RequestBody PloggingPathSaveRequestDto ploggingPathSaveRequestDto) {

        ploggingService.savePloggingPath(Plogging.to(memberId), ploggingPathSaveRequestDto);
        return ResponseFactory.success("플로깅 경로 저장 성공");
    }

    @GetMapping("/path")
    public ResponseEntity<?> getPloggingPath(@RequestParam Long ploggingId) {
        PloggingPathViewResponseDto ploggingPathViewResponseDto = ploggingService.getPloggingPath(
                ploggingId);

        return ResponseFactory.success("플로깅 경로 조회 성공", ploggingPathViewResponseDto);
    }

}
