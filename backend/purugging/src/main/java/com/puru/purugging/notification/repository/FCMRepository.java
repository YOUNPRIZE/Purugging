package com.puru.purugging.notification.repository;

import com.puru.purugging.notification.entity.FCMToken;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FCMRepository extends JpaRepository<FCMToken, Long> {
    List<FCMToken> findByMemberId(Long memberId);
    Optional<FCMToken> findByFirebaseToken(String firebaseToken);
}
