import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';

import'../screens/profile.dart';

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
  static const platformImgs = {
    'Codechef': 'assets/platform_logos/codechef_small.png',
    'Codeforces': 'assets/platform_logos/codeforces_small.png',
    'Spoj': 'assets/platform_logos/spoj_small.png',
    'Atcoder': 'assets/platform_logos/atcoder_small.png',
    'Hackerearth': 'assets/platform_logos/hackerearth_small.png',
    'Hackerrank': 'assets/platform_logos/hackerrank_small.png',
    'Uva': 'assets/platform_logos/uva_small.png',
    'Timus': 'assets/platform_logos/timus_small.png',
  };
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //SizedBox(width: 20),
                    Flexible(
                      child: Padding(
                          padding: new EdgeInsets.only(
                              left: 0.0, right: 6.0, top: 6.0, bottom: 6.0),
                          child: InkWell(
                              child: Text(
                                rec.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: ProfileScreen(
                                            handle: rec.id)));
                              }
                          )),
                    ),
                  ]),
              Divider(
                color: Colors.grey,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFF2542ff),
                      child: CircleAvatar(
                        backgroundColor: Color(0XFFeeeeee),
                        radius: 19,
                        child: Image.asset(RecentCard.platformImgs[rec.platform],
                          fit: BoxFit.cover,),
                      ),
                    ),
                    //SizedBox(width: 20),
                    Flexible(
                      child: Padding(
                          padding: new EdgeInsets.only(left: 0.0,right:6.0,top: 6.0,bottom: 6.0),
                          child:InkWell(child: Text(
                            rec.problemName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black
                            ),
                          ),
                            onTap: ()=>_launchURL(rec.problemNameStopStalkUrl),)
                      ),
                    ),
                  ]),
              Divider(
                color: Colors.grey,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '$rec.date',
                    style: TextStyle(
                        fontSize: 15, color: Colors.grey[800]),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Status: ",style: TextStyle(
                            fontSize: 15, color: Colors.grey[800]),
                        ),
                        WidgetSpan(
                          child: rec.status==true?
                          Icon(Icons.check, size: 14)
                              : Icon(Icons.close, size: 14)
                        )
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
