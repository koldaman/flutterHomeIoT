import 'package:home_iot/date_utils.dart';

class DoorData {
  DoorData({
    this.time,
    this.state,
  });

  String time;
  String state;

  bool get isValid => time != null && state != null;

  String get timeText => 'Čas: $time';
  DateTime get timeDateTime => DateUtils.parse(time);
  String get timeTextFormated => DateUtils.formatDateTime(timeDateTime);
  String get stateText => 'Stav: $state';
  String get stateTranslated => (state == 'Opened' ? 'Otevřené' : 'Zavřené') ;

  @override
  String toString() {
     return 'DoorData['
         + '$time, $state'
         + ']';
  }

}