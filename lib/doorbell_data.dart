import 'package:home_iot/date_utils.dart';

class DoorbellData {
  DoorbellData({
    this.time,
    this.duration
  });

  String time;
  String duration;

  bool get isValid => time != null && duration != null;

  String get timeText => 'Čas: $time';
  DateTime get timeDateTime => DateUtils.parse(time);
  String get timeTextFormated => DateUtils.formatDateTime(timeDateTime);
  String get durationText => 'Doba zvonění: $duration sec.';
  String get durationTextCondensed => '$duration sec.';
  double get durationNum => double.parse(duration.replaceAll(new RegExp(r','), '.').replaceAll(new RegExp(r'-'), ''), (s) => 0.0);

  @override
  String toString() {
     return 'DoorbellData['
         + '$time, $duration'
         + ']';
  }

}