import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:timer_builder/timer_builder.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../widgets/app_drawer.dart';
import '../widgets/preloader.dart';
import '../classes/contest_class.dart';

class UpcomingContestScreen extends StatefulWidget {
  static const routeName = '/upcoming-contests';

  @override
  _UpcomingContestState createState() => _UpcomingContestState();
}

class _UpcomingContestState extends State<UpcomingContestScreen> {
  Future<List<Contest>> _getContests() async {
    String url = "https://www.stopstalk.com/contests.json";
    var data = await http.get(url);
    var jsonData = jsonDecode(data.body);
    List<Contest> contests = [];
    for (var contest in jsonData["upcoming"]) {
      Contest cont = Contest(
          contest["Name"].replaceAll("\n", ""),
          contest["url"],
          contest["Platform"],
          contest["StartTime"],
          contest["Duration"],
          contest["EndTime"]);
      contests.add(cont);
    }
    return contests;
  }

  List<String> startTimes = ["Loading"];

  // Future<List<String>> _getStartTimes() async {
  //   startTimes = [];
  //   String url = "https://www.stopstalk.com/contests.json";
  //   var data = await http.get(url);
  //   var jsonData = jsonDecode(data.body);
  //   for (var contest in jsonData["upcoming"]) {
  //     startTimes.add(timeToDate(contest["StartTime"]));
  //   }
  // }

  String timeToDate(String startTime) {
    final List<String> months = [
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
      "Dec"
    ];
    startTime = startTime.substring(5);
    String month = startTime.substring(3, 6);
    int ind = months.indexOf(month) + 1;
    String date = startTime.substring(7, 11) + "-";
    if (ind < 10) {
      date = date + "0" + ind.toString() + "-";
    } else {
      date = date + ind.toString() + "-";
    }
    date = date + startTime.substring(0, 2) + " ";
    date = date + startTime.substring(12, 17);
    return date;
  }

  String timeLeft(DateTime due) {
    String retVal;

    Duration _timeUntilDue = due.difference(DateTime.now());

    int _daysUntil = _timeUntilDue.inDays;
    int _hoursUntil = _timeUntilDue.inHours - (_daysUntil * 24);
    int _minUntil =
        _timeUntilDue.inMinutes - (_daysUntil * 24 * 60) - (_hoursUntil * 60);
    int _secondUntil = _timeUntilDue.inSeconds -
        (_daysUntil * 24 * 60 * 60) -
        (_hoursUntil * 60 * 60) -
        (_minUntil * 60);

    String days, hours, mins, secs;

    if (_daysUntil < 10) {
      days = "0" + _daysUntil.toString();
    } else {
      days = _daysUntil.toString();
    }

    if (_hoursUntil < 10) {
      hours = "0" + _hoursUntil.toString();
    } else {
      hours = _hoursUntil.toString();
    }

    if (_minUntil < 10) {
      mins = "0" + _minUntil.toString();
    } else {
      mins = _minUntil.toString();
    }

    if (_secondUntil < 10) {
      secs = "0" + _secondUntil.toString();
    } else {
      secs = _secondUntil.toString();
    }

    retVal = days + " : " + hours + " : " + mins + " : " + secs;

    if (retVal.contains("-")) {
      retVal = "Contest Started";
    }

    return retVal;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // List<String> timeLeftStrings(List<String> times) {
  //   for (int i = 0; i < times.length; i++) {
  //     times[i] = timeLeft(DateTime.parse(times[i]));
  //   }
  // }

  // void _startTimer() {
  //   if (startTimes.length > 0) {
  //     Timer.periodic(Duration(seconds: 1), (timer) {
  //       setState(() {
  //         startTimes = timeLeftStrings(startTimes);
  //       });
  //     });
  //   } else {
  //     _getStartTimes();
  //   }
  // }

  final images = {
    "CODEFORCES":
        "https://1.bp.blogspot.com/-pBimI1ZhYAA/Wnde0nmCz8I/AAAAAAAABPI/5LZ2y9tBOZIV-pm9KNbyNy3WZJkGS54WgCPcBGAYYCw/s1600/codeforce.png",
    "CODECHEF":
        "https://i.pinimg.com/originals/c5/d9/fc/c5d9fc1e18bcf039f464c2ab6cfb3eb6.jpg",
    "HACKEREARTH":
        "https://upload.wikimedia.org/wikipedia/commons/e/e8/HackerEarth_logo.png",
    "HACKERRANK":
        "https://info.hackerrank.com/rs/487-WAY-049/images/Podcast-ChannelCover-Final.jpg",
    "OTHER":
        "https://coursereport-s3-production.global.ssl.fastly.net/rich/rich_files/rich_files/3942/s200/asia-developer-academy.png"
  };

  @override
  void initState() {
    super.initState();
    //_startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upcoming Contests',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: FutureBuilder(
          future: _getContests(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Preloader();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: SimpleFoldingCell(
                        frontWidget: frontWidget(
                            snapshot.data[index].name,
                            snapshot.data[index].platform,
                            snapshot.data[index].startTime),
                        innerTopWidget: innerTopWidget(
                            snapshot.data[index].name,
                            snapshot.data[index].platform,
                            snapshot.data[index].startTime),
                        innerBottomWidget: innerBottomWidget(
                            snapshot.data[index].startTime,
                            snapshot.data[index].url),
                        cellSize:
                            Size(MediaQuery.of(context).size.width, 125.0),
                        padding: EdgeInsets.all(10.0),
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: 10.0,
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }

  Widget frontWidget(String name, String image, String startTime) {
    String date = startTime.substring(0, 16);
    String time = startTime.substring(17);
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            final foldingCellState =
                context.findAncestorStateOfType<SimpleFoldingCellState>();
            foldingCellState?.toggleFold();
          },
          child: Container(
            color: Color(0xfafafa).withOpacity(1),
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: Colors.lightBlueAccent.shade100,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6.0,
                            color: Colors.grey,
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            child: images[image] != null
                                ? Image(
                                    image: NetworkImage(images[image]),
                                    height: 80.0,
                                    width: 80.0,
                                  )
                                : SizedBox(),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        color: Colors.indigo.shade50,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Colors.grey,
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: AutoSizeText(
                              name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 17,
                                letterSpacing: .3,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 8.0,
                                    bottom: 4.0),
                                child: Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                ),
                              ),
                              Text(
                                date,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.8,
                                  letterSpacing: .3,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 8.0, top: 4.0),
                                child: Icon(
                                  Icons.access_alarm,
                                  size: 20,
                                ),
                              ),
                              Text(
                                time,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.8,
                                  letterSpacing: .3,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //),
        );
      },
    );
  }

  Widget innerTopWidget(String name, String image, String startTime) {
    String date = startTime.substring(0, 16);
    String time = startTime.substring(17);
    return GestureDetector(
      onTap: null,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent.shade100,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
              ),
              Expanded(
                flex: 1,
                child: ClipRRect(
                  child: images[image] != null
                      ? Image(
                          image: NetworkImage(images[image]),
                          height: 80.0,
                          width: 80.0,
                        )
                      : SizedBox(),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: AutoSizeText(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 17,
                          letterSpacing: .3,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0, bottom: 4.0),
                          child: Icon(
                            Icons.calendar_today,
                            size: 20,
                          ),
                        ),
                        Text(
                          date,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.8,
                            letterSpacing: .3,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 4.0),
                          child: Icon(
                            Icons.access_alarm,
                            size: 20,
                          ),
                        ),
                        Text(
                          time,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.8,
                            letterSpacing: .3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget innerBottomWidget(String startTime, String url) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          final foldingCellState =
              context.findAncestorStateOfType<SimpleFoldingCellState>();
          foldingCellState?.toggleFold();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          child: Container(
            margin: EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6.0,
                  color: Colors.grey,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.hourglassHalf),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                    ),
                    TimerBuilder.periodic(Duration(seconds: 1),
                        builder: (context) {
                      return Text(
                        timeLeft(DateTime.parse(timeToDate(startTime))),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      );
                    })
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                  ),
                ),
                ButtonTheme(
                  child: RaisedButton.icon(
                    onPressed: () => {_launchURL(url)},
                    icon: Icon(
                      FontAwesomeIcons.link,
                      color: Colors.white,
                      size: 17.0,
                    ),
                    label: Padding(
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text("CONTEST LINK"),
                    ),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    color: Colors.blue,
                  ),
                  minWidth: 160.0,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
