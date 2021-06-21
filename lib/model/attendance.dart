import 'dart:core';

class Attendance {
  int id;
  int employeeId;
  String dtmIn;
  String addressIn;
  String dtmOut;
  String addressOut;
  String dailyReport;
  double latitudeIn;
  double longitudeIn;
  double latitudeOut;
  double longitudeOut;
  String dateCreated;

  Attendance(
      {this.id,
      this.employeeId,
      this.dtmIn,
      this.addressIn,
      this.dtmOut,
      this.addressOut,
      this.dailyReport,
      this.latitudeIn,
      this.longitudeIn,
      this.latitudeOut,
      this.longitudeOut,
      this.dateCreated});

  Attendance.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    employeeId = map['employeeId'];
    dtmIn = map['dtmIn'];
    addressIn = map['addressIn'];
    dtmOut = map['dtmOut'];
    addressOut = map['addressOut'];
    dailyReport = map['dailyReport'];
    latitudeIn = map['latitudeIn'];
    longitudeIn = map['longitudeIn'];
    latitudeOut = map['latitudeOut'];
    longitudeOut = map['longitudeOut'];
    dateCreated = map['dateCreated'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['dtmIn'] = this.dtmIn;
    data['addressIn'] = this.addressIn;
    data['dtmOut'] = this.dtmOut;
    data['addressOut'] = this.addressOut;
    data['dailyReport'] = this.dailyReport;
    data['latitudeIn'] = this.latitudeIn;
    data['longitudeIn'] = this.longitudeIn;
    data['latitudeOut'] = this.latitudeOut;
    data['longitudeOut'] = this.longitudeOut;
    data['dateCreated'] = this.dateCreated;
    return data;
  }

  ///dummy data for testing
  static String address =
      'Jl. Pakubuwono VI No.24, RT.9/RW.6, Gunung, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12120';

  static List<Attendance> createAttendanceData() {
    var attendance1 = Attendance(
        employeeId: 1,
        dtmIn: 'Monday, 17 May 2021, 08:00',
        addressIn: address,
        dtmOut: 'Monday, 17 May 2021, 17:00',
        addressOut: address,
        latitudeIn: -6.2334367,
        longitudeIn: 106.79363169999999,
        latitudeOut: -6.2334367,
        longitudeOut: 106.79363169999999,
        dailyReport: 'Membuat layout halaman login',
        dateCreated: DateTime.now().toString());
    var attendance2 = Attendance(
        employeeId: 1,
        dtmIn: 'Tuesday, 18 May 2021, 08:00',
        addressIn: address,
        dtmOut: 'Tuesday, 18 May 2021, 17:00',
        addressOut: address,
        latitudeIn: -6.2334367,
        longitudeIn: 106.79363169999999,
        latitudeOut: -6.2334367,
        longitudeOut: 106.79363169999999,
        dailyReport: 'Membuat layout halaman home',
        dateCreated: DateTime.now().toString());
    var attendance3 = Attendance(
        employeeId: 1,
        dtmIn: 'Wednesday, 19 May 2021, 08:00',
        addressIn: address,
        dtmOut: 'Wednesday, 19 May 2021, 17:00',
        addressOut: address,
        latitudeIn: -6.2334367,
        longitudeIn: 106.79363169999999,
        latitudeOut: -6.2334367,
        longitudeOut: 106.79363169999999,
        dailyReport: 'Membuat layout halaman home',
        dateCreated: DateTime.now().toString());
    var attendance4 = Attendance(
        employeeId: 1,
        dtmIn: 'Thursday, 20 May 2021, 08:00',
        addressIn: address,
        dtmOut: 'Thursday, 20 May 2021, 17:00',
        addressOut: address,
        dailyReport: 'Membuat layout halaman home',
        dateCreated: DateTime.now().toString());
    var attendance5 = Attendance(
        employeeId: 1,
        dtmIn: 'Friday, 21 May 2021, 08:00',
        addressIn: address,
        dtmOut: 'Friday, 21 May 2021, 17:00',
        addressOut: address,
        latitudeIn: -6.2334367,
        longitudeIn: 106.79363169999999,
        latitudeOut: -6.2334367,
        longitudeOut: 106.79363169999999,
        dailyReport: 'Membuat layout halaman history',
        dateCreated: DateTime.now().toString());
    var attendance6 = Attendance(
        employeeId: 1,
        dtmIn: 'Monday, 24 May 2021, 08:00',
        addressIn: address,
        dtmOut: 'Monday, 24 May 2021, 17:00',
        addressOut: address,
        latitudeIn: -6.2334367,
        longitudeIn: 106.79363169999999,
        latitudeOut: -6.2334367,
        longitudeOut: 106.79363169999999,
        dailyReport: 'Membuat layout halaman history',
        dateCreated: DateTime.now().toString());
    var attendance7 = Attendance(
        employeeId: 1,
        dtmIn: 'Tuesday, 25 May 2021, 08:00',
        addressIn: address,
        dtmOut: 'Tuesday, 25 May 2021, 17:00',
        addressOut: address,
        latitudeIn: -6.2334367,
        longitudeIn: 106.79363169999999,
        latitudeOut: -6.2334367,
        longitudeOut: 106.79363169999999,
        dailyReport: 'Membuat layout halaman splash screen',
        dateCreated: DateTime.now().toString());
    var attendance8 = Attendance(
        employeeId: 1,
        dtmIn: 'Wednesday, 26 May 2021, 08:00',
        addressIn: address,
        dtmOut: 'Wednesday, 26 May 2021, 17:00',
        addressOut: address,
        latitudeIn: -6.2334367,
        longitudeIn: 106.79363169999999,
        latitudeOut: -6.2334367,
        longitudeOut: 106.79363169999999,
        dailyReport: 'Membuat layout halaman profile',
        dateCreated: DateTime.now().toString());
    var attendance9 = Attendance(
        employeeId: 1,
        dtmIn: 'Thursday, 27 May 2021, 08:00',
        addressIn: address,
        dtmOut: 'Thursday, 27 May 2021, 17:00',
        addressOut: address,
        latitudeIn: -6.2334367,
        longitudeIn: 106.79363169999999,
        latitudeOut: -6.2334367,
        longitudeOut: 106.79363169999999,
        dailyReport: 'Membuat layout halaman profile',
        dateCreated: DateTime.now().toString());
    var attendance10 = Attendance(
        employeeId: 1,
        dtmIn: 'Friday, 28 May 2021, 08:00',
        addressIn: address,
        dtmOut: 'Friday, 28 May 2021, 17:00',
        addressOut: address,
        latitudeIn: -6.2334367,
        longitudeIn: 106.79363169999999,
        latitudeOut: -6.2334367,
        longitudeOut: 106.79363169999999,
        dailyReport: 'Testing full cycle apps',
        dateCreated: DateTime.now().toString());
    return [
      attendance1,
      attendance2,
      attendance3,
      attendance4,
      attendance5,
      attendance6,
      attendance7,
      attendance8,
      attendance9,
      attendance10
    ];
  }
}
