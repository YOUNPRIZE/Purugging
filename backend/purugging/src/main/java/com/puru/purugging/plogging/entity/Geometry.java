package com.puru.purugging.plogging.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.geo.Point;

import java.util.List;

@Data
@NoArgsConstructor
public class Geometry {
    private String type;
    private List<Point> coordinates;
}
