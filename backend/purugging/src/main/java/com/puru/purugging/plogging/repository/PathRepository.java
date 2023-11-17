package com.puru.purugging.plogging.repository;

import com.puru.purugging.plogging.entity.PathDocument;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PathRepository extends MongoRepository<PathDocument, String> {
    PathDocument findByPloggingId(Long ploggingId);
}
