import 'package:intl/intl.dart';

class DateUtils {

  static var cz_days = ['Pondělí', 'Úterý', 'Středa', 'Čtvrtek', 'Pátek', 'Sobota', 'Neděle'];

  static bool isToday(DateTime dt) {
    if (dt == null) return false;

    var now = new DateTime.now();
    return now.year == dt.year && now.month == dt.month && now.day == dt.day;
  }

  static String getCzDay(DateTime dt) {
    if (dt == null) return '';

    return cz_days[dt.weekday-1];
  }

  static String getCzDayShort(DateTime dt) {
    if (dt == null) return '';

    return getCzDay(dt).substring(0, 2);
  }

  static String formatDateTime(DateTime dt) {
    if (dt == null) return '';

    var now = new DateTime.now();

    if (isToday(dt)) {
      return 'Dnes ' + new DateFormat.Hms().format(dt);
    } else if(now.difference(dt).inDays < 7) { // neni starsi nez tyden
      return getCzDay(dt) + ' ' + new DateFormat.Hms().format(dt);
    }
    return new DateFormat.d().format(dt) + '.' + new DateFormat.M().format(dt) + '. ' +  new DateFormat.Hms().format(dt);
  }

  static DateTime parse(String formattedString) {

    final RegExp re = new RegExp(r'^([+-]?(\d{1,2})\.(\d{1,2})\.(\d{4,6}))' // Day part.
    r'(?:[ T](\d{1,2})(?::?(\d{1,2})(?::?(\d{1,2})(?:\.(\d{1,6}))?)?)?' // Time part.
    r'( ?[zZ]| ?([-+])(\d\d)(?::?(\d\d))?)?)?$'); // Timezone part.

    Match match = re.firstMatch(formattedString);
    if (match != null) {
      int parseIntOrZero(String matched) {
        if (matched == null) return 0;
        return int.parse(matched);
      }

      // Parses fractional second digits of '.(\d{1,6})' into the combined
      // microseconds.
      int parseMilliAndMicroseconds(String matched) {
        if (matched == null) return 0;
        int length = matched.length;
        assert(length >= 1);
        assert(length <= 6);

        int result = 0;
        for (int i = 0; i < 6; i++) {
          result *= 10;
          if (i < matched.length) {
            result += matched.codeUnitAt(i) ^ 0x30;
          }
        }
        return result;
      }

      int day = int.parse(match[2]);
      int month = int.parse(match[3]);
      int years = int.parse(match[4]);
      int hour = parseIntOrZero(match[5]);
      int minute = parseIntOrZero(match[6]);
      int second = parseIntOrZero(match[7]);

      return new DateTime(years, month, day, hour, minute, second);
    } else {
      // chyba
      return null;
//      throw new FormatException("Invalid date format", formattedString);
    }
  }
}