package com.puru.purugging.campaign.repository;

import com.puru.purugging.campaign.entity.Attendance;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {

    Page<Attendance> findAllByCampaignId(Long campaignId, Pageable pageable);

    Optional<Attendance> findByMemberIdAndCampaignId(Long memberId, Long campaignId);

    void deleteByMemberIdAndCampaignId(Long memberId, Long campaignId);

}
