package com.puru.purugging.common.pagination;

import java.util.List;
import lombok.Getter;
import org.springframework.data.domain.Page;

@Getter
public class MultiResponseDto<T> {

    //TODO Data List 필드
    private List<T> contents;
    //TODO PageInfo 필드
    //page,size,totalElements, totalPages;
    private PageInfo pageInfo;

    //TODO 생성자 (Pagination)
    public MultiResponseDto(List<T> contents, Page page) {
        this.contents = contents;
        this.pageInfo
                = new PageInfo(page.getNumber() + 1, page.getSize(), page.getTotalElements(),
                page.getTotalPages());
    }

    //Number : Page 가 상속받는 Slice 의 필드, 현재 페이지 쪽수(slice), 조건: positive
    //Size : Page 가 상속받는 Slice 의 필드, 한 페이지(slice)에 담을 데이터(elements) 수
    //TotalElements : Page 의 필드, Pagination 에 사용되는 전체 데이터(elements) 수
    //TotalPages : Page 의 필드, 전체 Page 수 ( = TotalElements 를 Size 로 나눈 수)
}

