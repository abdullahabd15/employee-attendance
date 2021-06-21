import 'dart:ui';

import 'package:employee_attendance/model/employee.dart';
import 'package:employee_attendance/repository/auth_repository.dart';
import 'package:employee_attendance/repository/employee_repository.dart';
import 'package:employee_attendance/widget/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'main_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen();

  final TextEditingController _textFieldController = TextEditingController();
  final EmployeeRepository _employeeRepository = EmployeeRepository();
  final AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(milliseconds: 1500), () => _showDialogInformation(context));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Image.asset(
                      'assets/images/fingerprints.png',
                      width: 200,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Halo!',
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Selamat datang di aplikasi Absensi Karyawan',
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35.0,
                    ),
                    Text(
                      'Silakan masukkan nomor karyawan anda di bawah ini',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: _textFieldController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nomor Karyawan'),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    LoadingButton(
                      icon: Icons.login,
                      title: 'Masuk',
                      onButtonPressed: (context, button) {
                        var employeeNumber = _textFieldController.text ?? '';
                        if (employeeNumber.isEmpty) {
                          FocusScope.of(context).unfocus();
                          Toast.show(
                              'Nomor Kayawan tidak boleh kosong!', context,
                              duration: 2);
                          return;
                        }
                        button.setLoadingState(true);
                        Future.delayed(Duration(milliseconds: 1500))
                            .then((value) {
                          button.setLoadingState(false);
                          _doLogin(context, employeeNumber);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doLogin(BuildContext context, String employeeNumber) async {
    var employee =
        await _employeeRepository.getEmployeeByEmployeeNumber(employeeNumber);
    if (employee == null) {
      _showDialogEmployeeNotFound(context, employeeNumber);
    } else {
      _authRepository.setCurrentUserLogin(employee.id);
      _navigateToMainScreen(context, employee);
    }
  }

  void _showDialogEmployeeNotFound(
      BuildContext context, String employeeNumber) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(
            'Nomor Karyawan "$employeeNumber" tidak ditemukan, silakan menghubungi Admin untuk mendaftar.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _showDialogInformation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(
          'Untuk keperluan testing aplikasi, silakan masukkan nomor karyawan "123456"',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _navigateToMainScreen(BuildContext context, Employee employee) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(
          employee: employee,
        ),
      ),
    );
  }
}
