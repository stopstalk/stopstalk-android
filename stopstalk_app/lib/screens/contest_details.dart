import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/contest_class.dart';

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
              Text(
                contest.name,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
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
                          fontSize: 20.0),
                    )
                  ],
                ),
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
                          fontSize: 20.0),
                    )
                  ],
                ),
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
                          fontSize: 20.0),
                    )
                  ],
                ),
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
