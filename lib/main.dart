import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_iot/sample_chart.dart';

import 'package:home_iot/weather_data.dart';
import 'package:home_iot/weather_item.dart';
import 'package:home_iot/weather_detail.dart';
import 'package:home_iot/doorbell_data.dart';
import 'package:home_iot/doorbell_detail.dart';
import 'package:home_iot/doorbell_item.dart';
import 'package:home_iot/door_data.dart';
import 'package:home_iot/door_detail.dart';
import 'package:home_iot/door_item.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  static var weatherDetail = new WeatherDetail(title: 'Weather charts');
  static var doorbellDetail = new DoorbellDetail(title: 'Doorbell event list');
  static var doorDetail = new DoorDetail(title: 'Door event list');

  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder> {
      WeatherDetail.routeName: (BuildContext context) => weatherDetail,
      DoorbellDetail.routeName: (BuildContext context) => doorbellDetail,
      DoorDetail.routeName: (BuildContext context) => doorDetail,
      SampleChart.routeName: (BuildContext context) => new SampleChart(title: 'Weather detail'),
    };

    return new MaterialApp(
      title: 'Home IoT',
      theme: new ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: new MyHomePage(title: 'Home IoT'),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  // FIXME fill with real identifiers
  static const String _apiKey = 'xxx';
  static const String _tempSheetId = 'xxx';
  static const String _doorbellSheetId = 'xxx';
  static const String _doorSheetId = 'xxx';

  @override
  void initState() {
    _handleRefresh();
  }

  final WeatherData weatherData = new WeatherData(inTemp: 'NA', outTemp: 'NA', humidity: 'NA', pressure: 'NA', vcc: 'NA', updated: 'NA');
  final List<DoorbellData> doorbellData = [new DoorbellData(time: '', duration: ''), new DoorbellData(time: '', duration: ''), new DoorbellData(time: '', duration: ''), new DoorbellData(time: '', duration: '')];
  final List<DoorData> doorData = [new DoorData(time: '', state: ''), new DoorData(time: '', state: ''), new DoorData(time: '', state: ''), new DoorData(time: '', state: '')];

  Future<Null> _handleRefresh() {
    var future = _loadData();
    future.then((content) {
      print('finished refresh' + content.toString());
    });
    return future;
  }

  Future _loadData() async {
    return Future.wait([_getActualWeatherData(), _getRangeWeatherData(), _getDoorbellData(), _getDoorData()])
        .then((List responses) => print(responses.map((resp) => print(resp.toString()))))
        .catchError((e) => handleError(e));
  }

  handleError(e) {
    print(e);
  }

  Future<WeatherData> _getActualWeatherData() async {
    String range = 'L5:P6';
    String url = 'https://sheets.googleapis.com/v4/spreadsheets/$_tempSheetId/values/$range?key=$_apiKey';
    var httpClient = createHttpClient();
    var response = await httpClient.read(url);
    Map data = JSON.decode(response);
    String outTemp = data['values'][0][0];
    String inTemp = data['values'][1][0];
    String humidity = data['values'][0][1];
    String pressure = data['values'][0][2];
    String vcc = data['values'][0][3];
    String lastUpdate = data['values'][1][4];

    if (!mounted) return null;

    setState(() {
      weatherData.outTemp = outTemp;
      weatherData.inTemp = inTemp;
      weatherData.updated = lastUpdate;
      weatherData.humidity = humidity;
      weatherData.pressure = pressure;
      weatherData.vcc = vcc;
    });
    return weatherData;
  }

  Future<List<WeatherData>> _getRangeWeatherData() async {
    String range = Uri.encodeFull("'Nedávná data'!A9:H");
    String url = 'https://sheets.googleapis.com/v4/spreadsheets/$_tempSheetId/values/$range?key=$_apiKey';
    var httpClient = createHttpClient();
    var response = await httpClient.read(url);
    Map data = JSON.decode(response);

    List values = data['values'];

    List<WeatherData> weatherDataList = values.where((listValues) => listValues.length >= 7).map((listValues) =>
      new WeatherData(
          inTemp: listValues.elementAt(7),
          outTemp: listValues.elementAt(2),
          humidity: listValues.elementAt(3),
          pressure: listValues.elementAt(4),
          vcc: listValues.elementAt(5),
      )).toList();

    setState(() {
      MyApp.weatherDetail.data.clear();
      MyApp.weatherDetail.data.addAll(weatherDataList);
    });

    if (!mounted) return null;

    return weatherDataList;
  }

  Future<List<DoorbellData>> _getDoorbellData() async {
    String range = Uri.encodeFull("'Data'!A4:C");
    String url = 'https://sheets.googleapis.com/v4/spreadsheets/$_doorbellSheetId/values/$range?key=$_apiKey';
    var httpClient = createHttpClient();
    var response = await httpClient.read(url);
    Map data = JSON.decode(response);

    List values = data['values'];

    List<DoorbellData> doorbellDataList = values.where((listValues) => listValues.length >= 3).map((listValues) =>
    new DoorbellData(
      time: listValues.elementAt(0),
      duration: listValues.elementAt(2)
    )).toList().reversed.toList();

    doorbellData.clear();
    doorbellData.addAll(doorbellDataList);
    setState(() {
      while (doorbellData.length < 4) { // at least 4 data values
        doorbellData.add(new DoorbellData(time: '', duration: ''));
      }
      MyApp.doorbellDetail.data.clear();
      MyApp.doorbellDetail.data.addAll(doorbellData);
    });

    if (!mounted) return null;

    return doorbellData;
  }

  Future<List<DoorData>> _getDoorData() async {
    String range = Uri.encodeFull("'Data'!A4:D");
    String url = 'https://sheets.googleapis.com/v4/spreadsheets/$_doorSheetId/values/$range?key=$_apiKey';
    var httpClient = createHttpClient();
    var response = await httpClient.read(url);
    Map data = JSON.decode(response);

    List values = data['values'];

    List<DoorData> doorDataList = values.where((listValues) => listValues.length >= 4).map((listValues) =>
    new DoorData(
        time: listValues.elementAt(0),
        state: listValues.elementAt(2)
    )).toList().reversed.toList();

    doorData.clear();
    doorData.addAll(doorDataList);
    setState(() {
      while (doorData.length < 4) { // at least 4 data values
        doorData.add(new DoorData(time: '', state: ''));
      }
      MyApp.doorDetail.data.clear();
      MyApp.doorDetail.data.addAll(doorData);
    });

    if (!mounted) return null;

    return doorData;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              }
          ),
        ]
      ),
      body: new RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: new ListView(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            children: <Widget>[
              new Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: new WeatherItem(data: weatherData)
              ),
              new Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: new DoorbellItem(data: doorbellData)
              ),
              new Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: new DoorItem(data: doorData)
              ),
            ]
        )
      ),
    );
  }

}
