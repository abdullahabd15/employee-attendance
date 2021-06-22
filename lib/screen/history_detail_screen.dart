import 'package:employee_attendance/model/attendance.dart';
import 'package:employee_attendance/model/employee.dart';
import 'package:employee_attendance/util/date_util.dart';
import 'package:flutter/material.dart';

class HistoryDetailScreen extends StatefulWidget {
  final Attendance attendance;
  final Employee employee;

  HistoryDetailScreen({this.attendance, this.employee});

  @override
  _HistoryDetailScreenState createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  String _dateInIndonesian;
  String _date;
  String _workDuration;
  String _overTimeDuration;
  String _lateTimeDuration;

  @override
  void initState() {
    super.initState();
    setState(() {
      _dateInIndonesian = DateUtil.toIndonesian(widget.attendance.dtmIn);
      _date = DateUtil.getDate(_dateInIndonesian);
      _workDuration = _getWorkDuration(widget.attendance.dtmIn, widget.attendance.dtmOut);
      _overTimeDuration = _getOverTimeDuration(widget.attendance.dtmOut);
      _lateTimeDuration = _getLateTimeDuration(widget.attendance.dtmIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Riwayat'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15.0,
              ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.employee.fullName,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(widget.employee.position ?? '-'),
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
                  Text(widget.employee.employeeNumber),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Durasi Kerja'),
                  Text(_workDuration),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Durasi Lembur'),
                  Text(_overTimeDuration),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Terlambat',
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    _lateTimeDuration,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                _date,
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
                    widget.attendance.dtmIn == null
                        ? '-'
                        : DateUtil.getTime(widget.attendance.dtmIn),
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
                  Flexible(child: Text(widget.attendance.addressIn ?? '-')),
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
                    widget.attendance.dtmOut == null
                        ? '-'
                        : DateUtil.getTime(widget.attendance.dtmOut),
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
                  Flexible(child: Text(widget.attendance.addressOut ?? '-')),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
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
                  widget.attendance.dailyReport ?? '',
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

  String _getWorkDuration(String dtmIn, String dtmOut) {
    try {
      var dtmFrom =
          dtmOut == null ? DateTime.now() : DateUtil.toDateTime(dtmOut);
      var dtmTo = DateUtil.toDateTime(dtmIn);
      return DateUtil.getHourDifference(dtmFrom, dtmTo);
    } catch (e) {
      return '-';
    }
  }

  String _getOverTimeDuration(String dateTime) {
    try {
      var dtm = DateUtil.toDateTime(dateTime);
      var dtmOut = DateTime(dtm.year, dtm.month, dtm.day, 17, 0);
      if (dateTime == null || dtm.isBefore(dtmOut) || dtm.isAtSameMomentAs(dtmOut)) return '-';
      return DateUtil.getHourDifference(dtm, dtmOut);
    } catch (e) {
      return '-';
    }
  }

  String _getLateTimeDuration(String dateTime) {
    try {
      var dtm = DateUtil.toDateTime(dateTime);
      var dtmIn = DateTime(dtm.year, dtm.month, dtm.day, 8, 0);
      if (dtm.isBefore(dtmIn) || dtm.isAtSameMomentAs(dtmIn)) return '-';
      return DateUtil.getHourDifference(dtm, dtmIn);
    } catch (e) {
      return '-';
    }
  }
}
