import 'package:employee_attendance/model/employee.dart';
import 'package:employee_attendance/repository/auth_repository.dart';
import 'package:employee_attendance/widget/loading_button.dart';
import 'package:employee_attendance/widget/profile_field.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Employee employee;

  ProfileScreen({this.employee});

  final AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    var _screenHeight = _mediaQuery.size.height;
    var _screenWidth = _mediaQuery.size.width;
    var _isPortrait = _mediaQuery.orientation == Orientation.portrait;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: _screenWidth,
                  height: _isPortrait ? _screenHeight * .32 : _screenHeight * .40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                    ),
                    color: Colors.blue
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80.0,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: _screenHeight * .068,
                        child: CircleAvatar(
                          radius: _screenHeight * .065,
                          foregroundImage:
                              AssetImage('assets/images/user.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _isPortrait ? _screenHeight * .27 : _screenHeight * .33),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              employee.fullName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              employee.position,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    ProfileField(
                      icon: Icons.person,
                      field: 'No. Karyawan',
                      value: employee.employeeNumber,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ProfileField(
                      icon: Icons.layers,
                      field: 'Divisi',
                      value: employee.division,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ProfileField(
                      icon: Icons.phone_android,
                      field: 'No. Hp',
                      value: employee.phoneNumber,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ProfileField(
                      icon: Icons.email,
                      field: 'Email',
                      value: employee.email,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ProfileField(
                      icon: Icons.location_history,
                      field: 'Alamat',
                      value: employee.address,
                    ),
                    SizedBox(
                      height: 36.0,
                    ),
                    LoadingButton(
                      icon: Icons.logout,
                      title: 'Keluar',
                      onButtonPressed: (context, button) {
                        _showConfirmationToLogout(context, button);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationToLogout(BuildContext context, LoadingState button) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              button.setLoadingState(true);
              Future.delayed(Duration(milliseconds: 1500)).then((value) {
                button.setLoadingState(false);
                _doLogout(context);
              });
            },
            child: Text('Ya'),
          ),
        ],
      ),
    );
  }

  void _doLogout(BuildContext context) async {
    var result = await _authRepository.removeCurrentUserLogin();
    if (result) {
      _navigateToLogin(context);
    }
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
