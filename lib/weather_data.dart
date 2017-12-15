class WeatherData {
  WeatherData({
    this.outTemp,
    this.inTemp,
    this.pressure,
    this.humidity,
    this.vcc,
    this.updated
  });

  String outTemp;
  String inTemp;
  String pressure;
  String humidity;
  String vcc;
  String updated;

  bool get isValid => inTemp != null && outTemp != null;

  String get title => '$outTemp°C / $inTemp°C';
  String get inTempText => '$inTemp°C';
  double get inTempNum => double.parse(inTemp.replaceAll(new RegExp(r','), '.'), (s) => 0.0);
  String get outTempText => '$outTemp°C';
  double get outTempNum => double.parse(outTemp.replaceAll(new RegExp(r','), '.'), (s) => 0.0);
  String get updatedText => 'Poslední aktualizace: $updated';
  String get pressureText => 'Tlak: $pressure hPa';
  double get pressureNum => double.parse(pressure.replaceAll(new RegExp(r','), '.').replaceAll(new RegExp(r'-'), ''), (s) => 0.0);
  String get humidityText => 'Vlhkost: $humidity %';
  double get humidityNum => double.parse(humidity.replaceAll(new RegExp(r','), '.').replaceAll(new RegExp(r'-'), ''), (s) => 0.0);
  String get vccText => 'VCC: $vcc V';
  double get vccNum => double.parse(vcc.replaceAll(new RegExp(r','), '.'), null);
  String get vccTextCondensed => '$vcc V';

  @override
  String toString() {
     return 'WeatherData['
         + '$inTemp, $outTemp, $humidity, $pressure, $vcc, $updated'
         + ']';
  }

}