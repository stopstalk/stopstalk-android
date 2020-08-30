import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../classes/contest_class.dart';
import 'contest_details.dart';

class UpcomingContestScreen extends StatelessWidget {
  static const routeName = '/upcoming-contests';

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

  final images = {
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
                      margin: EdgeInsets.only(
                          left: 10.0, top: 5.0, right: 10.0, bottom: 5.0),
                      shadowColor: Colors.teal,
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                        leading: Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                images[snapshot.data[index].platform]),
                            radius: 25.0,
                          ),
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
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      ContestPage(snapshot.data[index])));
                        },
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
