package com.puru.purugging.machine.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.puru.purugging.machine.entity.Machine;
import java.util.List;
import java.util.stream.Collectors;
import lombok.Builder;
import lombok.Getter;

@Getter
@JsonNaming(SnakeCaseStrategy.class)
public class MachineListResponseDto {

    private List<MachineDetailsResponseDto> details;

    @Builder
    public MachineListResponseDto(List<MachineDetailsResponseDto> details) {
        this.details = details;
    }

    public static MachineListResponseDto from(List<Machine> result) {
        return MachineListResponseDto.builder()
                .details(result.stream()
                        .map(MachineDetailsResponseDto::from)
                        .collect(Collectors.toList())
                )
                .build();
    }
}
