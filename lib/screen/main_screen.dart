import 'package:employee_attendance/model/employee.dart';
import 'package:employee_attendance/screen/attendance_screen.dart';
import 'package:employee_attendance/screen/history_screen.dart';
import 'package:employee_attendance/screen/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final Employee employee;

  const MainScreen({this.employee});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  Employee _employee;

  @override
  void initState() {
    super.initState();
    _employee = widget.employee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarItem(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
      ),
    );
  }

  List<Widget> _pages() => [
        AttendanceScreen(
          employee: _employee,
        ),
        HistoryScreen(
          employee: _employee,
        ),
        ProfileScreen(
          employee: _employee,
        ),
      ];

  List<BottomNavigationBarItem> _navBarItem() => [
        BottomNavigationBarItem(
          icon: Icon(Icons.fingerprint_sharp),
          label: 'Absen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Riwayat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ];
}
