package com.puru.purugging.plogging.dto;

import com.puru.purugging.plogging.entity.Geometry;
import com.puru.purugging.plogging.entity.Properties;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PloggingPathSaveRequestDto {
    private String type;
    private Geometry geometry;
    private Properties properties;
}

