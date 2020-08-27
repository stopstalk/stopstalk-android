import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class UpcomingContestScreen extends StatelessWidget {
  static const routeName = '/upcoming-contests';

  Future<List<Contest>> _getContests() async {
    String url = "https://www.stopstalk.com/contests.json";
    var data = await http.get(url);
    var jsonData = jsonDecode(data.body);
    List<Contest> contests = [];
    for (var contest in jsonData["upcoming"]) {
      Contest cont = Contest(
          contest["Name"],
          contest["url"],
          contest["Platform"],
          contest["StartTime"],
          contest["Duration"],
          contest["EndTime"]);
      contests.add(cont);
    }
    print(contests.length);
    return contests;
  }

  var images = {
    "CODEFORCES":
        "https://1.bp.blogspot.com/-pBimI1ZhYAA/Wnde0nmCz8I/AAAAAAAABPI/5LZ2y9tBOZIV-pm9KNbyNy3WZJkGS54WgCPcBGAYYCw/s1600/codeforce.png",
    "CODECHEF":
        "https://i.pinimg.com/originals/c5/d9/fc/c5d9fc1e18bcf039f464c2ab6cfb3eb6.jpg",
    "HACKEREARTH":
        "https://upload.wikimedia.org/wikipedia/commons/e/e8/HackerEarth_logo.png",
    "HACKERRANK":
        "https://info.hackerrank.com/rs/487-WAY-049/images/Podcast-ChannelCover-Final.jpg"
  };

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
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          shadowColor: Colors.teal,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  images[snapshot.data[index].platform]),
                              radius: 25.0,
                            ),
                            title: Text(snapshot.data[index].name),
                            subtitle: RichText(
                              text: TextSpan(
                                  text: "Start Time: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: snapshot.data[index].startTime,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal))
                                  ]),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          ContestPage(snapshot.data[index])));
                            },
                          ));
                    });
              }
            },
          ),
        ));
  }
}

class Contest {
  final String name;
  final String url;
  final String platform;
  final String startTime;
  final String duration;
  final String endTime;

  Contest(this.name, this.url, this.platform, this.startTime, this.duration,
      this.endTime);
}

class ContestPage extends StatelessWidget {
  final Contest contest;

  ContestPage(this.contest);

  var images = {
    "CODEFORCES":
        "https://1.bp.blogspot.com/-pBimI1ZhYAA/Wnde0nmCz8I/AAAAAAAABPI/5LZ2y9tBOZIV-pm9KNbyNy3WZJkGS54WgCPcBGAYYCw/s1600/codeforce.png",
    "CODECHEF":
        "https://i.pinimg.com/originals/c5/d9/fc/c5d9fc1e18bcf039f464c2ab6cfb3eb6.jpg",
    "HACKEREARTH":
        "https://upload.wikimedia.org/wikipedia/commons/e/e8/HackerEarth_logo.png",
    "HACKERRANK":
        "https://info.hackerrank.com/rs/487-WAY-049/images/Podcast-ChannelCover-Final.jpg"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Contests"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(images[contest.platform]),
                radius: 100.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Text(contest.name, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              RichText(
                text: TextSpan(
                    text: "Start Time: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
                    children: <TextSpan>[
                      TextSpan(
                          text: contest.startTime,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20.0))
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              RichText(
                text: TextSpan(
                    text: "Duration: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
                    children: <TextSpan>[
                      TextSpan(
                          text: contest.duration,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20.0))
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              RichText(
                text: TextSpan(
                    text: "End Time: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
                    children: <TextSpan>[
                      TextSpan(
                          text: contest.endTime,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20.0))
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              RaisedButton.icon(
                  onPressed: () => {_launchURL(contest.url)},
                  icon: Icon(Icons.call_made, color: Colors.white),
                  label: Text("Contest Link"),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
