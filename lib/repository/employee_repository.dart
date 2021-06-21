import 'package:employee_attendance/db/db_provider.dart';
import 'package:employee_attendance/model/employee.dart';

class EmployeeRepository {
  DbProvider dbProvider = DbProvider.db;

  Future<Employee> getEmployeeById(int employeeId) async {
    return await dbProvider.getEmployeeById(employeeId);
  }

  Future<Employee> getEmployeeByEmployeeNumber(String employeeNumber) async {
    return await dbProvider.getEmployeeByEmployeeNumber(employeeNumber);
  }

  void insertEmployee(Employee employee) async {
    dbProvider.addEmployee(employee);
  }
}