import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar.dart';
import 'package:heatmap_calendar/time_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class AcceptanceGraph extends StatelessWidget {
  final String handle;
  final graph;
  final List<int> colorNum = [1, 5, 10, 15, 20, 18, 30, 35, 4, 18];

  AcceptanceGraph({@required this.handle, @required this.graph});
  @override
  Widget build(BuildContext context) {
    graph.forEach((key, val) {
      var accepted = val['AC'],
          partiallyAccepted = val['PS'],
          editorials = val['EAC'];
      if (accepted == null) accepted = 0;
      if (partiallyAccepted == null) partiallyAccepted = 0;
      if (editorials == null) editorials = 0;
      // Math = Accepted - Not Accepted
      //      = (accepted + partiallyAccepted) - [total - (accepted + partiallyAccepted)]
      graph[key]['val'] =
          2 * (accepted + partiallyAccepted + editorials) - val['count'];
    });
    return Column(
      children: [
        HeatMapCalendar(
          input: {
            for (var i in graph.keys)
              TimeUtils.removeTime(DateTime.parse(i)): graph[i]['val']
          },
          colorThresholds: {
            1: Color(0xff776fff),
            10: Color(0xff1842ff),
            30: Color(0xff0018ca),
          },
          weekDaysLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
          monthsLabels: [
            "",
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          squareSize: 20.0,
          textOpacity: 0.3,
          labelTextColor: Colors.blueGrey,
          dayTextColor: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            height: 18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text('Less'),
                ),
                Container(
                  height: 18,
                  width: 18,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 18,
                  child: new Center(
                    child: new Container(
                      width: 4,
                      height: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 18,
                  width: 18,
                  color: Color(0xff776fff),
                ),
                SizedBox(
                  height: 18,
                  child: new Center(
                    child: new Container(
                      width: 4,
                      height: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 18,
                  width: 18,
                  color: Color(0xff1842ff),
                ),
                SizedBox(
                  height: 18,
                  child: new Center(
                    child: new Container(
                      width: 4,
                      height: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 18,
                  width: 18,
                  color: Color(0xff0018ca),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('More'),
                ),
                SizedBox(
                  width: 50,
                ),
                FlatButton(
                  color: Color(0xFF0018ca),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'Know more',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => _launchURL(handle),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

_launchURL(String handle) async {
  var url = 'https://www.stopstalk.com/user/profile/$handle';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
