package com.puru.purugging.global.storage;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.puru.purugging.global.exception.S3ErrorCode;
import com.puru.purugging.global.exception.S3Exception;
import com.puru.purugging.global.util.ImageUtil;
import com.puru.purugging.global.vo.Image;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@RequiredArgsConstructor
@Component
public class S3Uploader {

    private final AmazonS3 amazonS3;
    private final ImageUtil imageUtil;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    @Value("${cloud.aws.s3.urlPrefix}")
    private String s3UrlPrefix;

    public Image uploadImage(MultipartFile file, String dirName) {
        Image image = imageUtil.convertMultipartToImage(file);
        String fileName = convertImageName(dirName, image.getImageUUID(), image.getImageName(), image.getImageType().toString());
        image.setUrl(uploadImageToS3(fileName, file));

        return image;
    }

    public void deleteImage(Image image, String dirName) {
        if (image != null && image.getImageUUID() != null) {
            String fileName = convertImageName(dirName, image.getImageUUID(), image.getImageName(), image.getImageType().toString());
            amazonS3.deleteObject(bucket, fileName);
        }
    }

    private String convertImageName(String dirName, String UUID, String name, String type) {
        return dirName + "/" + UUID + "_" + name + "." + type;
    }


    public String uploadImageToS3(String fileName, MultipartFile file) {
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentType(file.getContentType());
        metadata.setContentLength(file.getSize());
        try {
            amazonS3.putObject(bucket, fileName, file.getInputStream(), metadata);
        } catch (Exception e) {
            throw new S3Exception(S3ErrorCode.FAIL_UPLOAD_S3);
        }

        return "https://" + bucket + "." + s3UrlPrefix + "/" + fileName;
    }
}