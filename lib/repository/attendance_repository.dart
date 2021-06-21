import 'package:employee_attendance/db/db_provider.dart';
import 'package:employee_attendance/model/attendance.dart';
import 'package:intl/intl.dart';

class AttendanceRepository {
  DbProvider dbProvider = DbProvider.db;

  Future<List<Attendance>> getAttendanceData(int employeeId) async {
    var results = await dbProvider.findAttendanceData(employeeId);
    return results;
  }

  Future<Attendance> getTodayAttendanceData(int employeeId) async {
    var results = await getAttendanceData(employeeId);
    if (results.isEmpty || results == null) return null;
    var attendance = results.firstWhere((Attendance atd) {
      var dateFormat = DateFormat("EEEE, dd MMMM yyyy, HH:mm");
      var dateAttendance = dateFormat.parse(atd.dtmIn);
      var dateNow = DateTime.now();
      var diff = DateTime(
              dateAttendance.year, dateAttendance.month, dateAttendance.day)
          .difference(DateTime(dateNow.year, dateNow.month, dateNow.day))
          .inDays;
      return diff == 0;
    }, orElse: () => null);
    return attendance;
  }

  void submitAttendanceIn(Attendance attendance) async {
    dbProvider.saveAttendance(attendance);
  }

  void submitAttendanceOut(Attendance attendance) async {
    dbProvider.updateAttendance(attendance);
  }
}
