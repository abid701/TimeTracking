package com.grassau.GrassauTime.services;


import com.grassau.GrassauTime.db.entities.WorkingLog;
import com.grassau.GrassauTime.db.repositories.WorkingLogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class WorkingLogService {

    private final WorkingLogRepository workingLogRepository;

    @Autowired
    public WorkingLogService(WorkingLogRepository workingLogRepository){
        this.workingLogRepository = workingLogRepository;
    }

    public Iterable<WorkingLog> getAllWorkingLog(){
        return workingLogRepository.findAll();
    }

//    public Iterable<Employees> getAllEmployeesFirstName(){
//        return workingLogsRepository.findAllEmployessFirstName();
//    }


}
