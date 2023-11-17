package com.puru.purugging.global.util;

import com.puru.purugging.global.vo.Image;
import com.puru.purugging.global.vo.ImageType;
import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@Component
public class ImageUtil {
    public Image convertMultipartToImage(MultipartFile file) {

        final String originalName = file.getOriginalFilename();
        final String name = FilenameUtils.getBaseName(originalName);
        assert FilenameUtils.getExtension(originalName) != null;
        final String type = FilenameUtils.getExtension(originalName).toUpperCase();

        return Image.builder()
                .imageType(ImageType.valueOf(type))
                .imageName(name)
                .imageUUID(UUID.randomUUID().toString())
                .build();
    }
}