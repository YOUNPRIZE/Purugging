package com.puru.purugging.machine.entity;

import com.puru.purugging.common.model.BaseTimeEntity;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class Machine extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "machine_id")
    private Long id;

    @Setter
    @Column(name = "bag_capacity")
    private Long bagCapacity;

    @Setter
    @Column(name = "pet_total_capacity")
    private Long petTotalCapacity;
    @Setter
    @Column(name = "can_total_capacity")
    private Long canTotalCapacity;
    @Setter
    @Column(name = "trash_total_capacity")
    private Long trashTotalCapacity;

    @Setter
    @Column(name = "pet_remaining_capacity")
    private Long petRemainingCapacity;
    @Setter
    @Column(name = "can_remaining_capacity")
    private Long canRemainingCapacity;
    @Setter
    @Column(name = "trash_remaining_capacity")
    private Long trashRemainingCapacity;

    @Setter
    @Column(name = "pet_filled_capacity")
    private Long petFilledCapacity;
    @Setter
    @Column(name = "can_filled_capacity")
    private Long canFilledCapacity;
    @Setter
    @Column(name = "trash_filled_capacity")
    private Long trashFilledCapacity;

    @Setter
    @Column(name = "machine_x")
    private Double machineX;
    @Setter
    @Column(name = "machine_y")
    private Double machineY;

    @Builder
    public Machine(Long id, Long bagCapacity, Long petTotalCapacity, Long canTotalCapacity,
            Long trashTotalCapacity, Long petRemainingCapacity, Long canRemainingCapacity,
            Long trashRemainingCapacity, Long petFilledCapacity, Long canFilledCapacity,
            Long trashFilledCapacity, Double machineX, Double machineY) {
        this.id = id;
        this.bagCapacity = bagCapacity;
        this.petTotalCapacity = petTotalCapacity;
        this.canTotalCapacity = canTotalCapacity;
        this.trashTotalCapacity = trashTotalCapacity;
        this.petRemainingCapacity = petRemainingCapacity;
        this.canRemainingCapacity = canRemainingCapacity;
        this.trashRemainingCapacity = trashRemainingCapacity;
        this.petFilledCapacity = petFilledCapacity;
        this.canFilledCapacity = canFilledCapacity;
        this.trashFilledCapacity = trashFilledCapacity;
        this.machineX = machineX;
        this.machineY = machineY;
    }
}
