//package com.grassau.GrassauTime.services;
//
//
//import com.grassau.GrassauTime.db.entities.WorkingLog;
//import com.grassau.GrassauTime.db.repositories.WorkingLogRepository;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.time.LocalTime;
//
//
//@Service
//public class WorkingLogService {
//
//    private final WorkingLogRepository workingLogRepository;
//
//    @Autowired
//    public WorkingLogService(WorkingLogRepository workingLogRepository){
//        this.workingLogRepository = workingLogRepository;
//    }
//
//    public Iterable<WorkingLog> getAllWorkingLog(){
//        return workingLogRepository.findAll();
//    }
//
//
//    public void saveTimeStarted(LocalTime timeStarted){
//        Iterable<WorkingLog> workingLogs = getAllWorkingLog();
//
//        for(WorkingLog workingLog : workingLogs){
//            System.out.println(workingLog);
//        }
//
//        //workingLogRepository.save();
//    }
//
//    public void saveTimeEnded(LocalTime timeEnded){
//       //
//    }
//
//    public void saveBreakStarted(LocalTime breakStarted){
//        //
//    }
//
//    public void saveBreakEnded(LocalTime breakEnded){
//        //
//    }



//    public Iterable<Employees> getAllEmployeesFirstName(){
//        return workingLogsRepository.findAllEmployessFirstName();
//    }


//}


package com.grassau.GrassauTime.services;

import com.grassau.GrassauTime.db.entities.Employee;
import com.grassau.GrassauTime.db.entities.WorkingLog;
import com.grassau.GrassauTime.db.repositories.EmployeeRepository;
import com.grassau.GrassauTime.db.repositories.WorkingLogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.Month;
import java.util.Optional;

@Service
public class WorkingLogService {

    private final WorkingLogRepository workingLogRepository;

    private final EmployeeRepository employeeRepository;

    @Autowired
    public WorkingLogService(WorkingLogRepository workingLogRepository, EmployeeRepository employeeRepository) {
        this.workingLogRepository = workingLogRepository;
        this.employeeRepository = employeeRepository;
    }

    public Iterable<WorkingLog> getAllWorkingLog(){
        return workingLogRepository.findAll();
    }


    public Employee getEmployeeByCardId(String cardId){
        return employeeRepository.findEmployeeByCardId(cardId);
    }
//    public Iterable<Employee> getAllEmployeesFirstName(){
//        return workingLogRepository.findAllEmployessFirstName();
//    }

    public Iterable<WorkingLog> getAllWorkingLogsByWorkDate(LocalDate date){
        return workingLogRepository.findAllByWorkDate(date);
    }

    public WorkingLog getWorkingLogByEmployeeAndWorkDate(Employee employee, LocalDate date){
        return workingLogRepository.findByEmployeeAndWorkDate(employee, date);
    }

    public Iterable<WorkingLog> getAllWorkingLogsByWorkDateBetween(LocalDate startDate, LocalDate endDate){
        return workingLogRepository.findAllByWorkDateBetween(startDate, endDate);
    }


    public void scanCard(String cardNumber) {
        LocalDate today = LocalDate.now();
        LocalTime currentTime = LocalTime.now();

        Optional<WorkingLog> existingLog = workingLogRepository.findByCardNumberAndWorkDate(cardNumber, today);

        if (existingLog.isPresent()) {
            WorkingLog log = existingLog.get();
            if(log.getWorkDate().equals(today)) {
                log.updateNextStep(currentTime);
                workingLogRepository.save(log);
            }
        } else {
            if (getEmployeeByCardId(cardNumber) != null){
                WorkingLog newLog = new WorkingLog();
                newLog.setEmployee(getEmployeeByCardId(cardNumber));
                newLog.setCardNumber(cardNumber);
                newLog.setWorkDate(today);
                newLog.setStartTime(currentTime);
                workingLogRepository.save(newLog);
            }

        }
    }
}
