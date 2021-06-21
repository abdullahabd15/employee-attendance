import 'dart:io';

import 'package:employee_attendance/model/attendance.dart';
import 'package:employee_attendance/model/employee.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  DbProvider._();

  static final DbProvider db = DbProvider._();
  static const String employee_table = 'employee';
  static const String attendance_table = 'attendance';
  static const int db_version = 6;
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "employeeAttendance.db");
    var db = await openDatabase(path, version: db_version, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE employee (' +
        'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        'employeeNumber TEXT, ' +
        'fullName TEXT, ' +
        'position TEXT, ' +
        'division TEXT, ' +
        'email TEXT, ' +
        'phoneNumber TEXT, ' +
        'address TEXT)');

    await db.execute('CREATE TABLE attendance(' +
        'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        'employeeId INTEGER, ' +
        'dtmIn TEXT, ' +
        'addressIn TEXT, ' +
        'dtmOut TEXT, ' +
        'addressOut TEXT, ' +
        'dailyReport TEXT, ' +
        'latitudeIn REAL, ' +
        'longitudeIn REAL, ' +
        'latitudeOut REAL, ' +
        'longitudeOut REAL, ' +
        'dateCreated TEXT)'
    );
  }

  void addEmployee(Employee employee) async {
    var dbClient = await database;
    dbClient.insert(employee_table, employee.toMap());
  }

  Future<Employee> getEmployeeById(int id) async {
    List<Map> results = await getEmployees();
    if (results.length > 0) {
      for (int i = 0; i < results.length; i++) {
        var emp = Employee.fromMap(results[i]);
        if (emp.id == id) {
          return emp;
        }
      }
      return null;
    } else {
      return null;
    }
  }

  Future<Employee> getEmployeeByEmployeeNumber(String employeeNumber) async {
    List<Map> results = await getEmployees();
    if (results.length > 0) {
      for (int i = 0; i < results.length; i++) {
        var emp = Employee.fromMap(results[i]);
        if (emp.employeeNumber == employeeNumber) {
          return emp;
        }
      }
      return null;
    } else {
      return null;
    }
  }

  Future<List<Map>> getEmployees() async {
    var dbClient = await database;
    return await dbClient.query(employee_table) ?? [];
  }

  void saveAttendance(Attendance attendance) async {
    var dbClient = await database;
    dbClient.insert(attendance_table, attendance.toMap());
  }

  void updateAttendance(Attendance attendance) async {
    var dbClient = await database;
    dbClient.update(attendance_table, attendance.toMap(),
        where: 'id = ?', whereArgs: [attendance.id]);
  }

  Future<List<Attendance>> findAttendanceData(int employeeId) async {
    var dbClient = await database;
    var results = await dbClient
        .query(attendance_table, where: 'employeeId = ?', whereArgs: [employeeId], orderBy: 'dateCreated DESC');
    List<Attendance> attendanceData = [];
    if (results.length > 0) {
      for (int i = 0; i < results.length; i++) {
        attendanceData.add(Attendance.fromMap(results[i]));
      }
    }
    return attendanceData;
  }

  Future close() async {
    var dbClient = await database;
    dbClient.close();
  }
}
