import 'dart:async';

import 'package:employee_attendance/enum/attendance_enum.dart';
import 'package:employee_attendance/enum/language_enum.dart';
import 'package:employee_attendance/model/attendance.dart';
import 'package:employee_attendance/model/employee.dart';
import 'package:employee_attendance/repository/attendance_repository.dart';
import 'package:employee_attendance/util/date_util.dart';
import 'package:employee_attendance/util/location_util.dart';
import 'package:employee_attendance/util/map_util.dart';
import 'package:employee_attendance/widget/date_time_attendance.dart';
import 'package:employee_attendance/widget/dialog_attendance_out.dart';
import 'package:employee_attendance/widget/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AttendanceScreen extends StatefulWidget {
  final Employee employee;

  const AttendanceScreen({this.employee});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  AttendanceRepository _attendanceRepository = AttendanceRepository();
  CameraPosition _cameraPosition;
  GoogleMapController _mapController;
  Employee _employee;
  Attendance _todayAttendance;
  Set<Marker> _markers = Set();
  AttendanceEnum _attendanceState = AttendanceEnum.ALREADY_OUT;
  String _dtmIn = '';
  String _dtmOut = '';
  GoogleMap _gMaps;

  @override
  void initState() {
    super.initState();
    _employee = widget.employee;
    _cameraPosition = CameraPosition(
      target: LatLng(0.0, 0.0),
      zoom: 15.0,
    );
    _getTodayAttendance(_employee.id);
    _gMaps = GoogleMap(
      initialCameraPosition: _cameraPosition,
      mapType: MapType.normal,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
      padding: const EdgeInsets.only(bottom: 130),
      markers: _markers,
      onMapCreated: (controller) => _mapController = controller,
    );
  }

  @override
  void setState(fn) {
    super.setState(fn);
    initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _gMaps,
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[400])
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(Icons.my_location),
                      ),
                    ),
                    onTap: () {
                      _getCurrentLocationData();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      child: Column(
                        children: [
                          Text(
                            'Halo, ${_employee.fullName}',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          DateTimeAttendance(
                            dtmIn: _dtmIn,
                            dtmOut: _dtmOut,
                            date: DateUtil.getCurrentDateTime(),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          _attendanceState != AttendanceEnum.ALREADY_OUT
                              ? LoadingButton(
                                  icon: Icons.fingerprint,
                                  title: _attendanceState ==
                                          AttendanceEnum.ATTENDED
                                      ? 'Absen Pulang'
                                      : 'Absen Masuk',
                                  onButtonPressed: (context, state) {
                                    _submitAttendance(state);
                                  })
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDialogDailyReport(String dtmOut) {
    if (context == null) return;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return DialogAttendanceOut(
            dtmOut: dtmOut,
            onButtonClicked: (context, state, dailyReport) {
              state.setLoadingState(true);
              _getAddressData((latLng, address) {
                Future.delayed(Duration(milliseconds: 1000)).then((value) {
                  state.setLoadingState(false);
                  Navigator.pop(context);
                  _submitAttendanceOut(dtmOut, latLng, address, dailyReport);
                });
              });
            },
          );
        });
  }

  void _submitAttendance(LoadingState state) async {
    var dateTime = DateUtil.getCurrentDateTime(language: LanguageEnum.ENG);
    _attendanceState == AttendanceEnum.ATTENDED
        ? _showDialogDailyReport(dateTime)
        : _submitAttendanceIn(state, dateTime);
  }

  void _submitAttendanceIn(LoadingState state, String dtmIn) async {
    state.setLoadingState(true);
    await Future.delayed(Duration(milliseconds: 1000));
    _getAddressData((latLng, address) async {
      var attendance = Attendance(
        employeeId: _employee.id,
        dtmIn: dtmIn,
        addressIn: address,
        latitudeIn: latLng.latitude,
        longitudeIn: latLng.longitude,
        dateCreated: DateTime.now().toString(),
      );
      _attendanceRepository.submitAttendanceIn(attendance);
      var marker =
          await MapUtil.createMarker(latLng, 'In', 'Absen Masuk', address);
      state.setLoadingState(false);
      setState(() {
        _attendanceState = AttendanceEnum.ATTENDED;
        _dtmIn = dtmIn;
        _todayAttendance = attendance;
        _markers.clear();
        _markers.add(marker);
      });
    });
  }

  void _submitAttendanceOut(
      String dtmOut, LatLng latLng, String address, String dailyReport) async {
    var attendance =
        await _attendanceRepository.getTodayAttendanceData(_employee.id);
    attendance.dtmOut = dtmOut;
    attendance.addressOut = address;
    attendance.latitudeOut = latLng.latitude;
    attendance.longitudeOut = latLng.longitude;
    attendance.dailyReport = dailyReport;
    _attendanceRepository.submitAttendanceOut(attendance);
    var marker =
        await MapUtil.createMarker(latLng, 'Out', 'Absen Pulang', address);
    setState(() {
      _dtmOut = dtmOut;
      _attendanceState = AttendanceEnum.ALREADY_OUT;
      _markers.add(marker);
    });
  }

  void _getAddressData(Function(LatLng, String) onAddressResult) async {
    var latLng = await LocationUtil.getCurrentLatLng();
    var address = await LocationUtil.getAddress(latLng);
    onAddressResult.call(latLng, address);
  }

  void _getCurrentLocationData() async {
    _getAddressData((latLng, address) {
      _animateCameraPosition(latLng);
    });
  }

  void _animateCameraPosition(LatLng latLng) {
    _cameraPosition = CameraPosition(
      target: latLng,
      zoom: 15.0,
    );
    _mapController
        ?.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  void _getTodayAttendance(int employeeId) async {
    _todayAttendance =
        await _attendanceRepository.getTodayAttendanceData(employeeId);
    if (_todayAttendance != null) {
      _setupMapMarkers((markerIn, markerOut) {
        setState(() {
          if (_todayAttendance.latitudeOut != null) {
            _attendanceState = AttendanceEnum.ALREADY_OUT;
            _markers.clear();
            _markers.add(markerIn);
            _markers.add(markerOut);
          } else {
            _attendanceState = AttendanceEnum.ATTENDED;
            _markers.clear();
            _markers.add(markerIn);
          }
          _dtmIn = _todayAttendance.dtmIn ?? '';
          _dtmOut = _todayAttendance.dtmOut ?? '';
        });
      });
    } else {
      _getCurrentLocationData();
      setState(() {
        _attendanceState = AttendanceEnum.NOT_ATTEND;
      });
    }
  }

  void _setupMapMarkers(
      Function(Marker markerIn, Marker markerOut) markerResults) async {
    var latLngIn = LatLng(
      _todayAttendance?.latitudeIn ?? 0.0,
      _todayAttendance?.longitudeIn ?? 0.0,
    );
    var markerIn = await MapUtil.createMarker(
      latLngIn,
      'In',
      'Absen Masuk',
      _todayAttendance?.addressIn ?? '',
    );
    var latLngOut = LatLng(
      _todayAttendance?.latitudeOut ?? 0.0,
      _todayAttendance?.longitudeOut ?? 0.0,
    );
    var markerOut = await MapUtil.createMarker(
      latLngOut,
      'Out',
      'Absen Pulang',
      _todayAttendance?.addressOut ?? '',
    );
    if (_todayAttendance.latitudeOut != null) {
      var latLngBound = MapUtil.getLatLngBounds(latLngIn, latLngOut);
      _mapController
          .animateCamera(CameraUpdate.newLatLngBounds(latLngBound, 150));
      markerResults.call(markerIn, markerOut);
    } else {
      _animateCameraPosition(latLngIn);
      markerResults.call(markerIn, null);
    }
  }
}
