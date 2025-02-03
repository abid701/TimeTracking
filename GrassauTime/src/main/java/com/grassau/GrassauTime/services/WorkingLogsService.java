package com.grassau.GrassauTime.services;


import com.grassau.GrassauTime.db.entities.WorkingLogs;
import com.grassau.GrassauTime.db.repositories.WorkingLogsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class WorkingLogsService {

    private final WorkingLogsRepository workingLogsRepository;

    @Autowired
    public WorkingLogsService(WorkingLogsRepository workingLogsRepository){
        this.workingLogsRepository = workingLogsRepository;
    }

    public Iterable<WorkingLogs> getAllWorkingLogs(){
        return workingLogsRepository.findAll();
    }

//    public Iterable<Employees> getAllEmployeesFirstName(){
//        return workingLogsRepository.findAllEmployessFirstName();
//    }


}
