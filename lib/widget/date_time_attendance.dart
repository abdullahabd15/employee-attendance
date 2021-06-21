import 'package:employee_attendance/util/date_util.dart';
import 'package:flutter/material.dart';

class DateTimeAttendance extends StatelessWidget {
  final String dtmIn;
  final String dtmOut;
  final String date;

  DateTimeAttendance({this.dtmIn, this.dtmOut, this.date});

  @override
  Widget build(BuildContext context) {
    String _dtmIn = DateUtil.toIndonesian(dtmIn);
    String _dtmOut = dtmOut;
    String _date = DateUtil.getDate(date);
    String _timeIn = DateUtil.getTime(_dtmIn);
    String _timeOut = DateUtil.getTime(_dtmOut);
    return Column(
      children: [
        Text(
          _date,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _createTimeWidget('Jam Masuk', _timeIn),
            Icon(
              Icons.location_history,
              size: 40.0,
              color: Colors.blue,
            ),
            _createTimeWidget('Jam Pulang', _timeOut),
          ],
        ),
      ],
    );
  }

  Widget _createTimeWidget(String title, String time) {
    return Column(
      children: [
        Text(title),
        SizedBox(
          height: 5.0,
        ),
        Text(
          time != '' && time != null ? time : '-',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
