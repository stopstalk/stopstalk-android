import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/profile.dart';

import '../classes/recent_submissions_class.dart';

import '../utils/platforms.dart' as platforms;

class RecentCard extends StatelessWidget {
  final Recent rec;
  final BuildContext context;
  final int i;

  RecentCard(
    this.rec,
    this.context,
    this.i,
  );

  static const platformImgs = platforms.platformImgs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        color: Color(0XFFeeeeee),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                //SizedBox(width: 20),
                Flexible(
                  child: Padding(
                    padding: new EdgeInsets.only(
                        left: 0.0, right: 6.0, top: 6.0, bottom: 6.0),
                    child: InkWell(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              rec.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              FontAwesomeIcons.externalLinkAlt,
                              size: 15,
                            ),
                          ]),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProfileScreen(
                              handle: rec.name, isUserItself: true);
                        }));
                      },
                    ),
                  ),
                )
              ]),
              Divider(
                color: Colors.grey,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFF2542ff),
                  child: CircleAvatar(
                    backgroundColor: Color(0XFFeeeeee),
                    radius: 15,
                    child: Image.asset(
                      RecentCard.platformImgs[rec.platform.toLowerCase()],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //SizedBox(width: 20),
                Container(
                  child: Padding(
                      padding: new EdgeInsets.only(
                          left: 0.0, right: 6.0, top: 6.0, bottom: 6.0),
                      child: InkWell(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                rec.problemName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                FontAwesomeIcons.externalLinkAlt,
                                size: 15,
                              ),
                            ]),
                        onTap: () => _launchURL(rec.problemNameStopStalkUrl),
                      )),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    rec.date,
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Status: ",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[800]),
                        ),
                        WidgetSpan(
                            child: rec.status == true
                                ? Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Colors.green,
                                  )
                                : Icon(Icons.close,
                                    size: 20, color: Colors.red))
                      ],
                    ),
                  )
                ],
              ),
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
