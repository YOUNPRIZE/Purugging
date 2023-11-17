package com.puru.purugging.common.response;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.puru.purugging.common.exception.ErrorCode;
import com.puru.purugging.common.pagination.MultiResponseDto;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

public class ResponseFactory {

    public static ResponseEntity<?> success(String message, Object data) {
        if(data instanceof MultiResponseDto) {
            MultiResponseDto multiResponse = (MultiResponseDto) data;
            SuccessResponseDto successResponse = new SuccessResponseDto(message, multiResponse);
            return ResponseEntity.status(200)
                                 .body(successResponse);
        }
        else {
            SuccessResponseDto successResponse = new SuccessResponseDto(message, data);
            return ResponseEntity.status(200)
                                 .body(successResponse);
        }
    }

    public static ResponseEntity<?> success(String message) {
        // 값이 없을때는 빈 배열을 담는다.
        SuccessResponseDto successResponse = new SuccessResponseDto(message, new ArrayList<>());
        return ResponseEntity.status(200)
                             .body(successResponse);
    }

    public static ResponseEntity<?> fail(ErrorCode errorCode) {
        FailResponseDto failResponse = new FailResponseDto(errorCode.getMessage(),
                errorCode.getErrorCode());
        return ResponseEntity.status(errorCode.getStatusCode())
                             .body(failResponse);
    }

    public static ResponseEntity<?> fail(String message, String errorCode, int statusCode) {
        FailResponseDto failResponse = new FailResponseDto(message, errorCode);
        return ResponseEntity.status(statusCode)
                             .body(failResponse);
    }

    public static void fail(HttpServletResponse response, String message, ErrorCode errorCode)
            throws IOException {
        FailResponseDto failResponse = new FailResponseDto(message, errorCode.getErrorCode());
        ObjectMapper mapper = new ObjectMapper();
        response.setStatus(errorCode.getStatusCode());
        response.setCharacterEncoding("UTF-8");
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.getWriter()
                .write(mapper.writeValueAsString(failResponse));

    }
}
