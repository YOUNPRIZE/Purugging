package com.puru.purugging.member.service;

import com.puru.purugging.global.storage.S3Uploader;
import com.puru.purugging.global.vo.Image;
import com.puru.purugging.member.dto.MemberSignUpRequestDto;
import com.puru.purugging.member.dto.MemberStatusCheckResponseDto;
import com.puru.purugging.member.dto.MyModifyRequestDto;
import com.puru.purugging.member.entity.Grade;
import com.puru.purugging.member.entity.Member;
import com.puru.purugging.member.entity.Status;
import com.puru.purugging.member.exception.MemberErrorCode;
import com.puru.purugging.member.exception.MemberException;
import com.puru.purugging.member.repository.MemberRepository;
import com.puru.purugging.plogging.entity.Plogging;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberService {

    private final MemberRepository memberRepository;
    private final S3Uploader s3Uploader;
    private final String MEMBER_S3_DIRNAME = "MEMBER";


    public MemberStatusCheckResponseDto checkIfMemberExists(String googleUid) {
        Optional<Member> memberOpt = memberRepository.findMemberByGoogleUid(googleUid);

        // 멤버가 존재하는 경우
        return memberOpt.map(MemberStatusCheckResponseDto::from).orElseGet(() -> {
            // 멤버가 존재하지 않는 경우
            return new MemberStatusCheckResponseDto(-1L, Status.NOT_REGISTERED);
        });
    }

    /**
     * memberId와 memberPassword만으로 멤버 생성하는 메서드
     * 이후, 기타 회원정보에 대해서는 update해준다.
     *
     * @param memberSignUpRequestDto
     */
    public Long createMember(MemberSignUpRequestDto memberSignUpRequestDto) {
        Member member = new Member(memberSignUpRequestDto);
        Member savedMember  = memberRepository.save(member);

        return savedMember.getId();
    }

    /**
     * Member 조회
     *
     * @param memberId
     * @return member 인스턴스
     */
    public Member getMemberDetails(Long memberId) {

        return memberRepository.findMemberById(memberId).orElseThrow(
                () -> new MemberException(MemberErrorCode.NOT_FOUND_MEMBER));
    }

    /**
     * Member 정보 업데이트
     * MyModifyRequestDto에 저장되어 있는 정보
     *
     * @param memberId
     * @param myModifyRequestDto
     */
    public void updateMember(Long memberId, MyModifyRequestDto myModifyRequestDto) {
        // memberId에 해당하는 멤버 불러오기
        Member member = memberRepository.findMemberById(memberId).orElseThrow(
                () -> new MemberException(MemberErrorCode.NOT_FOUND_MEMBER));

        // dto에 저장되어 있는 정보 업데이트
        member.updateInfo(myModifyRequestDto);

        // 업데이트된 사용자 정보 저장
        memberRepository.save(member);
    }

    /**
     * Member 탈퇴
     *
     * @param memberId
     */
    public void deleteMember(Long memberId) {
        // memberId에 해당하는 멤버 불러오기
        Member member = memberRepository.findMemberById(memberId).orElseThrow(
                () -> new MemberException(MemberErrorCode.NOT_FOUND_MEMBER));

        // 사용자 탈퇴 상태로 변경
        member.setStatus(Status.INACTIVE);

        // 업데이트된 사용자 정보 저장
        memberRepository.save(member);
    }

    /**
     * 탈퇴회원 상태변경
     *
     * @param myMemberId
     */
    public void rejoinMember(Long myMemberId) {
        Member member = memberRepository.findMemberById(myMemberId).orElseThrow(
                () -> new MemberException(MemberErrorCode.NOT_FOUND_MEMBER));

        member.setStatus(Status.ACTIVE);

        memberRepository.save(member);
    }

    /**
     * member의 프로필 이미지를 업데이트하는 메서드
     *
     * @param myMemberId
     * @param file
     */

    public void updateProfileImage(Long myMemberId, MultipartFile file) {
        // memberId에 해당하는 멤버 불러오기
        Member member = memberRepository.findMemberById(myMemberId).orElseThrow(
                () -> new MemberException(MemberErrorCode.NOT_FOUND_MEMBER));

        // 기존 프로필 사진 삭제
        if (member.getProfileImage().getImageUUID() != null) {
            final Image originalImage = member.getProfileImage();
            s3Uploader.deleteImage(originalImage, MEMBER_S3_DIRNAME);
        }

        // 프로필 사진 업데이트
        final Image image = s3Uploader.uploadImage(file, MEMBER_S3_DIRNAME);
        member.setProfileImage(image);

        // 업데이트된 사용자 정보 저장
        memberRepository.save(member);
    }

    /**
     * 회원의 프로필 사진을 삭제하는 메서드
     *
     * @param myMemberId
     */
    public void deleteProfileImage(Long myMemberId) {
        // memberId에 해당하는 멤버 불러오기
        Member member = memberRepository.findMemberById(myMemberId).orElseThrow(
                () -> new MemberException(MemberErrorCode.NOT_FOUND_MEMBER));

        // 기존 프로필 사진 삭제
        final Image originalImage = member.getProfileImage();
        s3Uploader.deleteImage(originalImage, MEMBER_S3_DIRNAME);

        // 업데이트된 사용자 정보 저장
        memberRepository.save(member);
    }

    /**
     * 닉네임 중복을 확인하는 서비스 메서드
     *
     * @param nickname
     * @return 이미 존재하면 0, 존재하지 않으면 1
     */
    public boolean checkNicknameAvailable(String nickname) {
        return !memberRepository.existsByNickname(nickname);
    }

    /**
     * 전화번호 중복을 확인하는 서비스 메서드
     *
     * @param phoneNumber
     * @return
     */

    public boolean checkPhoneNumberAvailable(String phoneNumber) { return !memberRepository.existsByPhoneNumber(phoneNumber); }

    public void updateMemberPloggingInfo(Long memberId, Plogging plogging) {

        Member findMember = getMemberDetails(memberId);

        findMember.setCumWeight(findMember.getCumWeight() + plogging.getGeneralTrashWeight());
        findMember.setCumPet(findMember.getCumPet() + plogging.getPetCount());
        findMember.setCumCan(findMember.getCumCan() + plogging.getCanCount());
        findMember.setPloggingCnt(findMember.getPloggingCnt()+1);

        Long pet = findMember.getCumPet();
        Long can = findMember.getCumCan();
        Double trash = findMember.getCumWeight();

        int total = (int) ((int) Math.round((pet * 0.3 + can * 0.3 + trash * 0.1) * 10) / 10.0);

        if (total < 5) findMember.setGrade(Grade.SEED);
        else if (total < 10) findMember.setGrade(Grade.SPROUT);
        else if (total < 15) findMember.setGrade(Grade.LEAF);
        else if (total < 20) findMember.setGrade(Grade.BRANCH);
        else if (total < 25) findMember.setGrade(Grade.FRUIT);
        else findMember.setGrade(Grade.TREE);
    }

    public void updateMemberCampaignInfo(Long memberId) {

        Member findMember = getMemberDetails(memberId);

        findMember.setCampaignCnt(findMember.getCampaignCnt() + 1);
    }

//    public void Updategrade(Long memberId) {
//        Member member = memberRepository.findMemberById(memberId).orElseThrow(
//                () -> new MemberException(MemberErrorCode.NOT_FOUND_MEMBER));
//
//        Long pet = member.getCumPet();
//        Long can = member.getCumCan();
//        Double trash = member.getCumWeight();
//
//        int total = (int) ((int) Math.round((pet * 0.3 + can * 0.3 + trash * 0.1) * 10) / 10.0);
//
//        if (total < 5) member.setGrade(Grade.SEED);
//        else if (total < 10) member.setGrade(Grade.SPROUT);
//        else if (total < 15) member.setGrade(Grade.LEAF);
//        else if (total < 20) member.setGrade(Grade.BRANCH);
//        else if (total < 25) member.setGrade(Grade.FRUIT);
//        else member.setGrade(Grade.TREE);
//
//        memberRepository.save(member);
//    }
}
