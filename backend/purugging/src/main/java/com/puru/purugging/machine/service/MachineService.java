package com.puru.purugging.machine.service;

import com.puru.purugging.machine.entity.Machine;
import com.puru.purugging.machine.exception.MachineErrorCode;
import com.puru.purugging.machine.exception.MachineException;
import com.puru.purugging.machine.repository.MachineRepository;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class MachineService {

    private final MachineRepository machineRepository;

    public void createMachine(Machine machine) {

        machineRepository.save(machine);
    }

    public void deleteMachine(Long machineId) {

        findVerifiedMachine(machineId);

        machineRepository.deleteById(machineId);
    }

    public Machine findMachine(Long machineId) {

        return findVerifiedMachine(machineId);
    }

    public List<Machine> findAllMachine() {
        return machineRepository.findAll();
    }

    private Machine findVerifiedMachine(Long machineId) {

        return machineRepository.findById(machineId).orElseThrow(
                () -> new MachineException(MachineErrorCode.NOT_FOUND_MACHINE)
        );
    }

    public void updateRemainingCapacity(Long machineId, Machine machine) {
        Machine findMachine = findVerifiedMachine(machineId);

        Optional.ofNullable(machine.getPetRemainingCapacity())
                .ifPresent(pet -> {
                    findMachine.setPetRemainingCapacity(pet);
                    findMachine.setPetFilledCapacity(findMachine.getPetTotalCapacity() - pet);
                });
        Optional.ofNullable(machine.getCanRemainingCapacity())
                .ifPresent(can -> {
                    findMachine.setCanRemainingCapacity(can);
                    findMachine.setCanFilledCapacity(findMachine.getCanTotalCapacity() - can);
                });
        Optional.ofNullable(machine.getTrashRemainingCapacity())
                .ifPresent(trash -> {
                    findMachine.setTrashRemainingCapacity(trash);
                    findMachine.setTrashFilledCapacity(findMachine.getTrashTotalCapacity() - trash);
                });

        machineRepository.save(findMachine);
    }

    public void resetRemainingCapacity(Long machineId) {
        Machine findMachine = findVerifiedMachine(machineId);

        findMachine.setCanFilledCapacity(0L);
        findMachine.setPetFilledCapacity(0L);
        findMachine.setTrashFilledCapacity(0L);
        findMachine.setCanRemainingCapacity(findMachine.getCanTotalCapacity());
        findMachine.setPetRemainingCapacity(findMachine.getPetTotalCapacity());
        findMachine.setTrashRemainingCapacity(findMachine.getTrashTotalCapacity());

        machineRepository.save(findMachine);
    }

    public void refillBags(Long machineId, Long request) {
        Machine findMachine = findVerifiedMachine(machineId);

        findMachine.setBagCapacity(request);

        machineRepository.save(findMachine);
    }
}
