import 'package:employee_attendance/model/attendance.dart';
import 'package:employee_attendance/model/employee.dart';
import 'package:employee_attendance/util/date_util.dart';
import 'package:flutter/material.dart';

class HistoryDetailScreen extends StatelessWidget {
  final Attendance attendance;
  final Employee employee;

  const HistoryDetailScreen({this.attendance, this.employee});

  @override
  Widget build(BuildContext context) {
    var dateInIndonesian = DateUtil.toIndonesian(attendance.dtmIn);
    var date = DateUtil.getDate(dateInIndonesian);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 15.0, left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 40,
                      foregroundImage: AssetImage('assets/images/iklimah.jpg')),
                  SizedBox(
                    width: 15.0,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          employee.fullName,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(employee.position ?? '-'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('No. Karyawan'),
                  Text(employee.employeeNumber),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Durasi Kerja'),
                  Text('-'),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Durasi Lembur'),
                  Text('-'),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Terlambat'),
                  Text('-'),
                ],
              ),
              SizedBox(height: 5.0,),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                date,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Text('Jam Masuk :'),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    attendance.dtmIn == null
                        ? '-'
                        : DateUtil.getTime(attendance.dtmIn),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Flexible(child: Text(attendance.addressIn ?? '-')),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Text('Jam Pulang :'),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    attendance.dtmOut == null
                        ? '-'
                        : DateUtil.getTime(attendance.dtmOut),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Flexible(child: Text(attendance.addressOut ?? '-')),
                ],
              ),
              SizedBox(height: 5.0,),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(height: 15.0),
              Text(
                'Laporan',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(3.0),
                ),
                constraints: BoxConstraints(minHeight: 100.0),
                child: Text(
                  attendance.dailyReport ?? '',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
