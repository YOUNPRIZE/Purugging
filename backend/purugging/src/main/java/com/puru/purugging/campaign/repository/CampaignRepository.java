package com.puru.purugging.campaign.repository;

import com.puru.purugging.campaign.entity.Campaign;
import com.puru.purugging.campaign.entity.Campaign.CampaignStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface CampaignRepository extends JpaRepository<Campaign, Long> {
    @Query("SELECT c FROM Campaign c WHERE c.date = :threeDaysLater AND c.campaignStatus = :campaignStatus")
    List<Campaign> findByDateAfterAndCampaignStatus(@Param("threeDaysLater") LocalDateTime threeDaysLater, @Param("campaignStatus") Campaign.CampaignStatus campaignStatus);

    Page<Campaign> findAllByCampaignStatus(CampaignStatus campaignStatus, Pageable pageable);

    Page<Campaign> findAllByMemberIdAndCampaignStatus(Long memberId, CampaignStatus campaignStatus, Pageable pageable);
}
