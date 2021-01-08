import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../classes/contest_class.dart';
import '../../screens/upcoming_contest_screen.dart';
import '../../utils/platforms.dart';

class UpcomingContests extends StatelessWidget {
  final images = platformImgs;

  Future<List<Contest>> _getContests() async {
    String url = "https://kontests.net/api/v1/all";
    var data = await http.get(url);
    var jsonData = List<Map<String, dynamic>>.from(jsonDecode(data.body));
    List<Contest> contests = [];
    for (var contest in jsonData) {
      Contest cont = Contest(contest["name"], contest["url"], contest["site"],
          contest["start_time"], contest["duration"], contest["end_time"]);
      if (contest["site"] == 'HackerRank' ||
          contest["site"] == 'CodeChef' ||
          contest["site"] == 'HackerEarth' ||
          contest["site"] == 'Codeforces' ||
          contest["site"] == 'AtCoder' ||
          contest["site"] == 'Spoj' ||
          contest["site"] == 'Timus' ||
          contest["site"] == 'Uva')
        contests.add(cont);
    }
    return contests.reversed.toList();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffeeeeee),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.grey,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          Text(
            "Upcoming Contests",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          FutureBuilder(
            future: _getContests(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  height: 100.0,
                  child: Center(
                    child: Text(
                      "Loading...",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    padding: EdgeInsets.all(5.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                snapshot.data[index].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: CircleAvatar(
                                maxRadius: 20,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image(
                                    image: AssetImage(
                                      images[snapshot.data[index].platform
                                          .toLowerCase()],
                                    ),
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                child: FloatingActionButton(
                                  heroTag: "btn$index",
                                  child: Icon(
                                    FontAwesomeIcons.link,
                                    size: 17.0,
                                  ),
                                  backgroundColor:
                                      Theme.of(context).buttonColor,
                                  onPressed: () {
                                    _launchURL(snapshot.data[index].url);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
          ),
          Container(
            width: 180.0,
            child: RaisedButton(
              elevation: 5,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Theme.of(context).buttonColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 20,
                  ),
                  AutoSizeText(
                    ' View All Contests',
                    maxLines: 1,
                    minFontSize: 7,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(UpcomingContestScreen.routeName);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
          ),
        ],
      ),
    );
  }
}
