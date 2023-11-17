package com.puru.purugging.plogging.dto;

import com.puru.purugging.plogging.entity.Geometry;
import com.puru.purugging.plogging.entity.PathDocument;
import com.puru.purugging.plogging.entity.Properties;
import lombok.Getter;
import org.springframework.data.geo.Point;
import org.springframework.data.mongodb.core.geo.GeoJsonLineString;

import java.util.List;
import java.util.stream.Collectors;

@Getter
public class PloggingPathViewResponseDto {
    private String type;
    private Geometry geometry;
    private Properties properties;

    public PloggingPathViewResponseDto(PathDocument pathDocument) {
        this.type = "Feature";
        this.geometry = convertGeoJsonLineStringToGeometry(pathDocument.getGeometry());
        this.properties = new Properties();

        this.properties.setStartTime(pathDocument.getStartTime());
        this.properties.setEndTime(pathDocument.getEndTime());
    }

    private Geometry convertGeoJsonLineStringToGeometry(GeoJsonLineString geoJsonLineString) {
        Geometry geometry = new Geometry();
        geometry.setType(geoJsonLineString.getType()); // "LineString"

        List<Point> coordinates = geoJsonLineString.getCoordinates().stream()
                .map(geoJsonPoint -> new Point(geoJsonPoint.getX(), geoJsonPoint.getY()))
                .collect(Collectors.toList());

        geometry.setCoordinates(coordinates);
        return geometry;
    }
}

