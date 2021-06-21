import 'package:employee_attendance/model/attendance.dart';
import 'package:employee_attendance/util/date_util.dart';
import 'package:employee_attendance/widget/date_time_attendance.dart';
import 'package:flutter/material.dart';

class ItemHistory extends StatelessWidget {
  final Attendance attendance;
  final Function(Attendance attendance) onItemClicked;

  const ItemHistory({this.attendance, this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    var dtmIn = attendance.dtmIn;
    var dtmOut = attendance.dtmOut;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: Material(
        child: Card(
          child: InkWell(
            onTap: () {
              onItemClicked.call(attendance);
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  DateTimeAttendance(
                    dtmIn: dtmIn,
                    dtmOut: dtmOut,
                    date: DateUtil.toIndonesian(dtmIn),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
