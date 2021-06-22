import 'package:employee_attendance/enum/language_enum.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static const dayInIndonesian = [
    '',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];

  static const dayInEnglish = [
    '',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  static const monthInIndonesian = [
    '',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static const monthInEnglish = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static String getCurrentDate({LanguageEnum language = LanguageEnum.ID}) {
    return toStringDate(DateTime.now(), language);
  }

  static String getCurrentDateTime({LanguageEnum language = LanguageEnum.ID}) {
    return toStringDateTime(DateTime.now(), language);
  }

  static String toStringDate(DateTime dateTime, LanguageEnum language) {
    try {
      String monthName = language == LanguageEnum.ID
          ? monthInIndonesian[dateTime.month]
          : monthInEnglish[dateTime.month];
      String dayName = language == LanguageEnum.ID
          ? dayInIndonesian[dateTime.weekday]
          : dayInEnglish[dateTime.weekday];
      return '$dayName, ${dateTime.day} $monthName ${dateTime.year}';
    } catch (e) {
      return '';
    }
  }

  static String toStringDateTime(DateTime dateTime, LanguageEnum language) {
    try {
      String monthName = language == LanguageEnum.ID
          ? monthInIndonesian[dateTime.month]
          : monthInEnglish[dateTime.month];
      String dayName = language == LanguageEnum.ID
          ? dayInIndonesian[dateTime.weekday]
          : dayInEnglish[dateTime.weekday];
      String hour = dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
      String minute = dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute.toString();
      return '$dayName, ${dateTime.day} $monthName ${dateTime.year}, $hour:$minute';
    } catch (e) {
      return '';
    }
  }

  static String toIndonesian(String dateTime) {
    try {
      var splitString = dateTime.split(' ');
      var monthName = splitString[2];
      var dayName = splitString[0].substring(0, (splitString[0].length - 1));
      var monthIndex = monthInEnglish.indexOf(monthName);
      var dayIndex = dayInEnglish.indexOf(dayName);
      return '${dayInIndonesian[dayIndex]}, ${splitString[1]} ${monthInIndonesian[monthIndex]} ${splitString[3]} ${splitString[4]}';
    } catch (e) {
      return '';
    }
  }

  static String toEnglish(String dateTime) {
    try {
      var splitString = dateTime.split(' ');
      var monthName = splitString[2];
      var dayName = splitString[0].substring(0, (splitString[0].length - 1));
      var monthIndex = monthInIndonesian.indexOf(monthName);
      var dayIndex = dayInIndonesian.indexOf(dayName);
      return '${dayInIndonesian[dayIndex]}, ${splitString[1]} ${monthInEnglish[monthIndex]} ${splitString[3]} ${splitString[4]}';
    } catch (e) {
      return '';
    }
  }

  static String getTime(String dateTime) {
    if (dateTime == null || dateTime == '') return '';
    return dateTime.split(',').last.trim();
  }

  static String getDate(String dateTime) {
    if (dateTime == null || dateTime == '') return '';
    var splitString = dateTime.split(',');
    return '${splitString[0]},${splitString[1]}';
  }

  static String getHourDifference(DateTime dtmFrom, DateTime dtmTo) {
    try {
      var diff = dtmFrom.difference(dtmTo).inMinutes;
      var hour = diff ~/ 60;
      var minutes = diff % 60;
      return '$hour Jam $minutes Menit';
    } catch (e) {
      return '';
    }
  }

  static DateTime toDateTime(String dtm) {
    try {
      var dateFormat = DateFormat("EEEE, dd MMMM yyyy, HH:mm");
      var dateTime = dateFormat.parse(dtm);
      return dateTime;
    } catch (e) {
      print(e);
      return DateTime.now();
    }
  }
}
