package com.puru.purugging.plogging.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.geo.GeoJsonLineString;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@NoArgsConstructor
@Document(collection = "path")
public class PathDocument {
    @Id
    private String id;
    private Long ploggingId;
    private GeoJsonLineString geometry;
    private String startTime;
    private String endTime;
}
