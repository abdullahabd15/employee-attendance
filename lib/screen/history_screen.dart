import 'package:employee_attendance/item_list/item_history.dart';
import 'package:employee_attendance/model/attendance.dart';
import 'package:employee_attendance/model/employee.dart';
import 'package:employee_attendance/repository/attendance_repository.dart';
import 'package:employee_attendance/screen/history_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HistoryScreen extends StatelessWidget {
  final Employee employee;
  final AttendanceRepository _attendanceRepository = AttendanceRepository();

  HistoryScreen({this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Riwayat Absensi')),
      ),
      body: Container(
        child: FutureBuilder(
          builder: (context, snapshot) {
            List<Attendance> dataList = snapshot.data;
            if (snapshot.hasError) {
              return _showEmptyHistory();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: SpinKitDualRing(
                    color: Colors.blue,
                    size: 40.0,
                  ),
                ),
              );
            }
            if (dataList != null && dataList.isNotEmpty) {
              return _showHistories(dataList);
            } else {
              return _showEmptyHistory();
            }
          },
          future: _showHistoryAttendance(employee.id),
        ),
      ),
    );
  }

  Widget _showHistories(List<Attendance> dataList) => Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ItemHistory(
              attendance: dataList[index],
              onItemClicked: (attendance) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HistoryDetailScreen(
                      attendance: attendance,
                      employee: employee,
                    );
                  }),
                );
              },
            );
          },
          scrollDirection: Axis.vertical,
          itemCount: dataList.length,
        ),
      );

  Widget _showEmptyHistory() => Container(
        child: Center(
          child: Text(('Tidak ada data')),
        ),
      );

  Future<List<Attendance>> _showHistoryAttendance(int employeeId) async {
    await Future.delayed(Duration(milliseconds: 300));
    return await _attendanceRepository.getAttendanceData(employeeId);
  }
}
