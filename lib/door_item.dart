import 'package:home_iot/door_data.dart';
import 'package:home_iot/door_detail.dart';

import 'package:flutter/material.dart';

class DoorItem extends StatelessWidget {
  DoorItem({ Key key, @required this.data })
      : /*assert(data != null && data.isNotEmpty),*/
        super(key: key);

  static final double height = 284.0;
  final List<DoorData> data;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle timeStyle = theme.textTheme.display1.copyWith(color: Colors.white);
    final TextStyle stateStyle = theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle updatedStyle = theme.textTheme.subhead;

    void _goToDetail() {
      Navigator.pushNamed(context, DoorDetail.routeName);
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
                      'images/door1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  new Positioned(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child: new Text(data[0].timeTextFormated, style: timeStyle),
                  ),
                  new Positioned(
                    bottom: 16.0,
                    left: 16.0,
//                    right: 16.0,
                    child: new Text(data[0].stateTranslated, style: stateStyle),
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
                          new Text(data[1].timeTextFormated),
                          new Text(data[1].stateTranslated)
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text(data[2].timeTextFormated),
                          new Text(data[2].stateTranslated)
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text(data[3].timeTextFormated),
                          new Text(data[3].stateTranslated)
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