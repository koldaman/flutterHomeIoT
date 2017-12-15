import 'package:flutter/material.dart';
import 'package:home_iot/door_data.dart';

class DoorDetail extends StatefulWidget {
  DoorDetail({Key key, this.title}) : super(key: key);

  static const String routeName = "/DoorDetail";

  List<DoorData> _data = [];

  final String title;

  @override
  _DoorDetailState createState() => new _DoorDetailState();

  List<DoorData> get data => _data;
}

class _DoorDetailState extends State<DoorDetail> {

  @override
  void initState() {
    print('door detail init');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle lineStyle = theme.textTheme.body2.copyWith(color: Colors.black87);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children:
          widget.data.map((listValues) =>
            new Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(listValues.timeTextFormated, style: lineStyle,),
                    new Text(listValues.stateText, style: lineStyle,)
                  ],
                )
            )
          ).toList()
      )

    );
  }

}