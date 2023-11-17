package com.puru.purugging.notification.repository;

import com.puru.purugging.notification.entity.Receive;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReceiveRepository extends JpaRepository<Receive, Long> {
    Page<Receive> findAllByMemberId(Long memberId, Pageable pageable);
}
