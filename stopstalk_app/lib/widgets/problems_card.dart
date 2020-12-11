import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable/expandable.dart';

import'../classes/problems_class.dart';

class ProblemsCard extends StatelessWidget {
  final Problems recom;
  final BuildContext context;
  final int i;
  final Animation animation;
  ProblemsCard(
      this.recom,
      this.context,
      this.i,
      this.animation,
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
  Tween<Offset> _offSetTween = Tween(
    begin: Offset(1, 0),
    end: Offset.zero,
  );
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
          child:Column(children:[
            Expandable(
              collapsed: ExpandableButton(
                child: FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: _offSetTween.animate(animation),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        color: Color(0XFFeeeeee),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Padding(
                                      padding: new EdgeInsets.only(left: 8.0,right:8.0,top: 6.0,bottom: 6.0),
                                      child:InkWell(child: Text(
                                        recom.problemName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                        onTap: ()=>_launchURL(recom.problemUrl),)
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Image.asset(
                                    ProblemsCard.platformImgs[recom.platform],
                                    height: 80,
                                    width: 60,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.lightbulb_outline,),
                                  onPressed: ()=>_launchURL(recom.editorialUrl),
                                )
                              ],
                            )),
                            Expanded(
                              child: Column(
                                children: [
                                  Icon(Icons.check),
                                  Divider(),
                                  Text(recom.accuracy),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Icon(Icons.arrow_upward_rounded),
                                  Divider(),
                                  Text(recom.totalSubmissions),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),),
              expanded: Column(
                  children: [
                    ExpandableButton(       // <-- Collapses when tapped on
                      child: FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: _offSetTween.animate(animation),
                          child: Container(
                            padding: const EdgeInsets.all(4.0),width: double.infinity,
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              color: Color(0XFFeeeeee),
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                child:
                                Wrap(
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  children: List<Widget>.generate(recom.tags.length, (int index) {
                                    return Chip(
                                      label: Text(recom.tags[index]),
                                    );
                                  }),
                                ),

                              ),),),),),)
                  ]
              ),)])
      );}
    _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

