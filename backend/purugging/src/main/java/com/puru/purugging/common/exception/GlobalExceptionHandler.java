package com.puru.purugging.common.exception;


import com.puru.purugging.common.response.ResponseFactory;
import javax.validation.ConstraintViolationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<?> handleCustomException(CustomException e){
        e.printStackTrace();
        logging(e);
        return ResponseFactory.fail(e.getErrorCode());
    }

    @ExceptionHandler(BindException.class)
    public ResponseEntity<?> handleBindException(BindException e){
        logging(e);
        return ResponseFactory.fail(e.getMessage(), CommonErrorCode.INVALID_INPUT.getErrorCode(), HttpStatus.BAD_REQUEST.value());
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<?> handleConstraintViolationException(ConstraintViolationException e) {
        logging(e);
        return ResponseFactory.fail(e.getMessage(), CommonErrorCode.INVALID_INPUT.getErrorCode(), HttpStatus.BAD_REQUEST.value());
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<?> handleHttpMessageNotReadableException(
            HttpMessageNotReadableException e) {
        logging(e);
        return ResponseFactory.fail(e.getMessage(), CommonErrorCode.INVALID_INPUT.getErrorCode(), HttpStatus.BAD_REQUEST.value());
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> handleException(Exception e){
        logging(e);
        e.printStackTrace();
        ErrorCode serverError = CommonErrorCode.SERVER_ERROR;
        return ResponseFactory.fail(e.getMessage(), serverError.getErrorCode(),serverError.getStatusCode());
    }

    private static void logging(Exception e){
        log.warn("[ERROR]"+e.getMessage());
    }
}
