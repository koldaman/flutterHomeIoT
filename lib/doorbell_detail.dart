import 'package:flutter/material.dart';
import 'package:home_iot/doorbell_data.dart';

class DoorbellDetail extends StatefulWidget {
  DoorbellDetail({Key key, this.title}) : super(key: key);

  static const String routeName = "/DoorbellDetail";

  List<DoorbellData> _data = [];

  final String title;

  @override
  _DoorbellDetailState createState() => new _DoorbellDetailState();

  List<DoorbellData> get data => _data;
}

class _DoorbellDetailState extends State<DoorbellDetail> {

  @override
  void initState() {
    print('doorbell detail init');
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
                    new Text(listValues.durationTextCondensed, style: lineStyle,)
                  ],
                )
            )
          ).toList()
      )

    );
  }

}