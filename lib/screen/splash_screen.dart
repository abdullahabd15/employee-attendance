import 'dart:async';

import 'package:employee_attendance/model/attendance.dart';
import 'package:employee_attendance/model/employee.dart';
import 'package:employee_attendance/repository/attendance_repository.dart';
import 'package:employee_attendance/repository/auth_repository.dart';
import 'package:employee_attendance/repository/employee_repository.dart';
import 'package:employee_attendance/screen/login_screen.dart';
import 'package:employee_attendance/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _employeeRepository = EmployeeRepository();
  var _attendanceRepository = AttendanceRepository();
  var _authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    _setupDummyData();
    Timer(Duration(seconds: 3), () {
      var currentUser = _currentUserLogin();
      currentUser.then((value) {
        if (value == 0 || value == null) {
          _navigateToLogin();
        } else {
          var employee = _employeeRepository.getEmployeeById(value);
          employee.then((emp) => {
                if (emp == null)
                  {_navigateToLogin()}
                else
                  {_navigateToMainScreen(emp)}
              });
        }
      });
    });
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  void _navigateToMainScreen(Employee employee) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(
          employee: employee,
        ),
      ),
    );
  }

  Future<int> _currentUserLogin() async {
    return await _authRepository.currentUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue[800],
            Colors.blue[400]
          ],
            begin: Alignment.bottomRight,
            end: Alignment.topRight,),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/fingerprints.png',
                  width: 250,
                ),
                SizedBox(
                  height: 15.0,
                ),
                SpinKitDualRing(
                  color: Colors.white,
                  size: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///setup dummy data for testing purpose
  void _setupDummyData() async {
    //insert employee
    var employee = Employee.createEmployee();
    var existingEmployee =
        await _employeeRepository.getEmployeeById(employee.id);
    if (existingEmployee == null) {
      _employeeRepository.insertEmployee(employee);
    }

    //insert attendance data list
    var attendancesData = Attendance.createAttendanceData();
    var existingData = await _attendanceRepository
        .getAttendanceData(attendancesData.first.employeeId);
    if (existingData == null || existingData.isEmpty) {
      for (int i = 0; i < attendancesData.length; i++) {
        _attendanceRepository.submitAttendanceIn(attendancesData[i]);
      }
    }
  }
}
