package com.puru.purugging.plogging.repository;

import com.puru.purugging.plogging.entity.Plogging;
import com.puru.purugging.plogging.entity.PloggingStatusInfo;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface PloggingRepository extends JpaRepository<Plogging, Long> {

    @Query("SELECT new com.puru.purugging.plogging.entity.PloggingStatusInfo(p.id, p.memberId, p.ploggingStatus) FROM Plogging p WHERE p.memberId = :memberId ORDER BY p.createDate DESC")
    Optional<PloggingStatusInfo> findStatusByMemberId(Long memberId, PageRequest of);

    Optional<Plogging> findTopByMemberIdOrderByCreateDateDesc(Long memberId);

    Page<Plogging> findAllByMemberId(Long memberId, Pageable pageable);
}

