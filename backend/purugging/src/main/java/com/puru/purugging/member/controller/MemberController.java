package com.puru.purugging.member.controller;

import com.puru.purugging.common.response.ResponseFactory;
import com.puru.purugging.member.dto.*;
import com.puru.purugging.member.entity.Member;
import com.puru.purugging.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/members")
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;

    // 가입한 회원인지 확인하고 가입했다면 memeberId 전달
    @GetMapping("/exists")
    public ResponseEntity<?> checkMemberExists(@RequestParam(name="google_uid") String googleUid) {
        MemberStatusCheckResponseDto memberStatusCheckResponseDto = memberService.checkIfMemberExists(googleUid);

        return ResponseFactory.success("회원여부 확인 성공", memberStatusCheckResponseDto);
    }

    // 회원가입
    @PostMapping("/signup")
    public ResponseEntity<?> createMember(@RequestBody MemberSignUpRequestDto memberSignUpRequestDto) {
        Long memberId = memberService.createMember(memberSignUpRequestDto);
        MemberIdResponseDto memberIdResponseDto = new MemberIdResponseDto(memberId);

        return ResponseFactory.success("회원 생성 성공", memberIdResponseDto);
    }

    // 회원 정보 조회
    @GetMapping("/info")
    public ResponseEntity<?> getMemberDetails(@RequestParam(name = "member_id") Long memberId) {
        Member result = memberService.getMemberDetails(memberId);

        return ResponseFactory.success("회원 상세조회 성공", MemberViewResponseDto.from(result));
    }

    // 내 정보 조회
    @GetMapping("/me")
    public ResponseEntity<?> getMyDetails(@RequestParam(name = "my_member_id") Long myMemberId) {
        Member result = memberService.getMemberDetails(myMemberId);

        return ResponseFactory.success("회원 상세조회 성공", MyViewResponseDto.from(result));
    }

    // 내 정보 변경
    @PatchMapping("/me")
    public ResponseEntity<?> updateMember(@RequestParam(name = "my_member_id") Long myMemberId, @RequestBody MyModifyRequestDto myModifyRequestDto) {
        memberService.updateMember(myMemberId, myModifyRequestDto);

        return ResponseFactory.success("회원 정보 업데이트 성공");
    }

    // 회원탈퇴
    // ***** 추후 탈퇴한 멤버에 대한 처리 필요(인덱스 제거, 회원 검색 제거 등) *****
    @DeleteMapping("/me")
    public ResponseEntity<?> deleteMember(@RequestParam(name = "my_member_id") Long myMemberId) {
        memberService.deleteMember(myMemberId);

        return ResponseFactory.success("회원 탈퇴 성공");
    }

    // 탈퇴 회원 재가입
    @PatchMapping("/rejoin")
    public ResponseEntity<?> rejoinMember(@RequestParam(name = "my_member_id") Long myMemberId) {
        memberService.rejoinMember(myMemberId);

        return ResponseFactory.success("회원 재활성화 성공");
    }

    // 프로필 사진 변경
    @PatchMapping("/profile_image")
    public ResponseEntity<?> updateProfileImage(@RequestParam(name = "my_member_id") Long myMemberId, @RequestPart("file") MultipartFile file) {
        memberService.updateProfileImage(myMemberId, file);

        return ResponseFactory.success("프로필 사진 업데이트 성공");
    }

    // 프로필 사진 삭제
    @DeleteMapping("/profile_image")
    public ResponseEntity<?> deleteProfileImage(@RequestParam(name = "my_member_id") Long myMemberId) {
        memberService.deleteProfileImage(myMemberId);

        return ResponseFactory.success("프로필 사진 삭제 성공");
    }

    // 닉네임 중복 확인
    @GetMapping("/nickname")
    public ResponseEntity<?> checkNicknameAvailable(@RequestParam("nickname") String nickname) {

        return ResponseFactory.success("닉네임 중복확인 성공", memberService.checkNicknameAvailable(nickname));
    }

    // 전화번호 중복 확인
    @GetMapping("/phone_number")
    public ResponseEntity<?> checkPhoneNumberAvailable(@RequestParam("phone_number") String phoneNumber) {

        return ResponseFactory.success("닉네임 중복확인 성공", memberService.checkPhoneNumberAvailable(phoneNumber));
    }

}
