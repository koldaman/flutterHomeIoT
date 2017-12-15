import 'package:flutter/material.dart';
import 'package:home_iot/weather_data.dart';
import 'package:flutter_charts/flutter_charts.dart';

class WeatherDetail extends StatefulWidget {
  WeatherDetail({Key key, this.title}) : super(key: key);

  static const String routeName = "/WeatherDetail";

  List<WeatherData> _data = [];

  final String title;

  @override
  _WeatherDetailState createState() => new _WeatherDetailState();

  List<WeatherData> get data => _data;
}

class _WeatherDetailState extends State<WeatherDetail> {

  LineChartOptions getChartOptions() {
    LineChartOptions lineChartOptions = new LineChartOptions();
    lineChartOptions.lineStrokeWidth = 2.0;
    lineChartOptions.hotspotOuterRadius = 0.0;
    lineChartOptions.hotspotInnerRadius = 0.0;
    lineChartOptions.legendContainerMarginTB = 0.0;
    lineChartOptions.xLabelsPadTB = 0.0;
    lineChartOptions.yLabelsPadTB = 0.0;
    lineChartOptions.gridLinesColor = Colors.white;
    return lineChartOptions;
  }

  ChartData getChartDataOutTemp(Color color) {
    ChartData chartData = new ChartData();
    chartData.dataRows = [
      widget.data.map((data) => data.outTempNum).toList()
    ];
    chartData.xLabels = widget.data.map((data) => data.updated).toList();
    chartData.dataRowsColors = [
      color,
    ];
    return chartData;
  }

  ChartData getChartDataInTemp(Color color) {
    ChartData chartData = new ChartData();
    chartData.dataRows = [
      widget.data.map((data) => data.inTempNum).toList()
    ];
    chartData.xLabels = widget.data.map((data) => data.updated).toList();
    chartData.dataRowsColors = [
      color,
    ];
    return chartData;
  }

  ChartData getChartDataPressure(Color color) {
    ChartData chartData = new ChartData();
    chartData.dataRows = [
      widget.data.map((data) => data.pressureNum).toList()
    ];
    chartData.xLabels = widget.data.map((data) => data.updated).toList();
    chartData.dataRowsColors = [
      color,
    ];
    return chartData;
  }

  ChartData getChartDataHumidity(Color color) {
    ChartData chartData = new ChartData();
    chartData.dataRows = [
      widget.data.map((data) => data.humidityNum).toList()
    ];
    chartData.xLabels = widget.data.map((data) => data.updated).toList();
    widget.data.map((data) => data.humidityNum).toList().forEach((d) => print('hum: ' + d.toString()));
    chartData.dataRowsColors = [
      color,
    ];
    return chartData;
  }

  ChartData getChartDataVcc(Color color) {
    ChartData chartData = new ChartData();
    chartData.dataRows = [
      widget.data.map((data) => data.vccNum).toList()
    ];
    chartData.xLabels = widget.data.map((data) => data.updated).toList();
    chartData.dataRowsColors = [
      color,
    ];
    return chartData;
  }

  void _chartStateChanger() {
    setState(() {
    });
  }

  @override
  void initState() {
    _chartStateChanger();
    print('init');
  }

  @override
  Widget build(BuildContext context) {

    LineChart lineChartOutTemp = new LineChart(
      painter: new LineChartPainter(),
      layouter: new LineChartLayouter(
          chartData: getChartDataOutTemp(Colors.greenAccent),
          chartOptions: getChartOptions()),
    );

    LineChart lineChartInTemp = new LineChart(
      painter: new LineChartPainter(),
      layouter: new LineChartLayouter(
          chartData: getChartDataInTemp(Colors.blueAccent),
          chartOptions: getChartOptions()),
    );

    LineChart lineChartPressure = new LineChart(
      painter: new LineChartPainter(),
      layouter: new LineChartLayouter(
          chartData: getChartDataPressure(Colors.black87),
          chartOptions: getChartOptions()),
    );

    LineChart lineChartHumidity = new LineChart(
      painter: new LineChartPainter(),
      layouter: new LineChartLayouter(
          chartData: getChartDataHumidity(Colors.cyanAccent),
          chartOptions: getChartOptions()),
    );

    LineChart lineChartVcc = new LineChart(
      painter: new LineChartPainter(),
      layouter: new LineChartLayouter(
          chartData: getChartDataVcc(Colors.redAccent),
          chartOptions: getChartOptions()),
    );

    final ThemeData theme = Theme.of(context);
    final TextStyle headerStyle = theme.textTheme.headline.copyWith(color: Colors.black45);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        children: <Widget>[
          new Text('Outdoor temperature', style: headerStyle),
          new Container(
            height: 220.0,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                new Expanded(
                  child:  lineChartOutTemp,
                ),
              ],
            ),
          ),
          new Text('Indoor temperature', style: headerStyle),
          new Container(
            height: 220.0,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                new Expanded(
                  child:  lineChartInTemp,
                ),
              ],
            ),
          ),
          new Text('Pressure', style: headerStyle),
          new Container(
            height: 220.0,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                new Expanded(
                  child:  lineChartPressure,
                ),
              ],
            ),
          ),
          new Text('Humidity', style: headerStyle),
          new Container(
            height: 220.0,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                new Expanded(
                  child:  lineChartHumidity,
                ),
              ],
            ),
          ),
          new Text('Sensor voltage', style: headerStyle),
          new Container(
            height: 220.0,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                new Expanded(
                  child:  lineChartVcc,
                ),
              ],
            ),
          ),
        ],
      )

    );
  }

}