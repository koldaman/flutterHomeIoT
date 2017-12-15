import 'package:home_iot/weather_data.dart';
import 'package:home_iot/weather_detail.dart';

import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  WeatherItem({ Key key, @required this.data })
      : assert(data != null && data.isValid),
        super(key: key);

  static final double height = 272.0;
  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle outTempStyle = theme.textTheme.display3.copyWith(color: Colors.black54);
    final TextStyle inTempStyle = theme.textTheme.display1.copyWith(color: Colors.black26);
    final TextStyle updatedStyle = theme.textTheme.subhead;

    void _goToDetail() {
      Navigator.pushNamed(context, WeatherDetail.routeName);
//      Navigator.pushNamed(context, SampleChart.routeName);
    }

    return new Container(
      padding: const EdgeInsets.all(8.0),
      height: height,
      child: new Card(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // photo and title
            new SizedBox(
              height: 134.0,
              child: new Stack(
                children: <Widget>[
                  new Positioned.fill(
                    child: new Image.asset(
                      'images/weather1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  new Positioned(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child: new Text(data.outTempText, style: outTempStyle),
                  ),
                  new Positioned(
                    bottom: 16.0,
//                    left: 16.0,
                    right: 16.0,
                    child: new Text(data.inTempText, style: inTempStyle),
                  ),
                ],
              ),
            ),
            // description and share/expore buttons
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: new DefaultTextStyle(
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: updatedStyle,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text(data.humidityText),
                          new Text(data.pressureText),
                          new Text(data.vccTextCondensed),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: new Text(data.updatedText, style: updatedStyle.copyWith(color: Colors.black54, fontSize: 12.0)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // share, explore buttons
            new ButtonTheme.bar(
              child: new ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  new FlatButton(
                    child: const Text('Detail'),
                    textColor: Colors.amber.shade500,
                    onPressed: _goToDetail
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}