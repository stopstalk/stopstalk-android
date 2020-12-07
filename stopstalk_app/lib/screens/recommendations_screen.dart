import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable/expandable.dart';
import 'package:sliding_card/sliding_card.dart';

import '../widgets/app_drawer.dart';
import'../classes/problems_class.dart';

class RecommendationsScreen extends StatefulWidget {
  static const routeName = '/recommendations';

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
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  List<Problems> recom = [];
  bool flag = false;
  Tween<Offset> _offSetTween = Tween(
    begin: Offset(1, 0),
    end: Offset.zero,
  );
  final GlobalKey<AnimatedListState> _animatedListKey =
  GlobalKey<AnimatedListState>();

  Future<List<Problems>> _getRecommendations() async {
    for (int i = 1; i < 5; i++) {
      if (i % 2 == 0) {
        Problems prob = Problems(
            problemName: 'Special Permutation',
            platform: 'Codechef',
            problemUrl: 'https://codeforces.com/contest/1454/problem/A',
            editorialUrl: 'https://codeforces.com/contest/1454/problem/B',
            totalSubmissions: '500',
            accuracy: '25%',
            tags: [
              'hard','easy','dp'
            ]
        );
        recom.add(prob);
      } else {
        Problems prob = Problems(
            problemName: 'Special Permutation',
            platform: 'Codeforces',
            problemUrl: 'https://codeforces.com/contest/1454/problem/A',
            editorialUrl: 'https://codeforces.com/contest/1454/problem/B',
            totalSubmissions: '500',
            accuracy: '25%',
            tags: [
              'hard','easy','dp','easy','dp','easy','dp','easy','dp','easy','dp'
            ]
        );
        recom.add(prob);
      }
    }
    recom.length == 0 ? flag = true : flag = false;
    return recom;
  }

  Future<List<Problems>> myF;

  @override
  void initState() {
    myF = _getRecommendations();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommendations',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              FutureBuilder(
                future: myF,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: flag != true
                          ? AnimatedList(
                        key: _animatedListKey,
                        primary: true,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        initialItemCount: snapshot.data.length,
                        itemBuilder: (context, i, animation) {
                          return buildRecommendationItem(
                              snapshot.data[i], context, i, animation);
                        },
                      )
                          : _showNoRecommendation(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error);
                  } else {
                    return Text('no error and no data');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRecommendationItem(Problems recom, BuildContext context, int i, animation) {
    return ExpandableNotifier(
        child:Column(children:[
          Expandable(           // <-- Driven by ExpandableController from ExpandableNotifier
            collapsed: ExpandableButton(
              child: FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: _offSetTween.animate(animation),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
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
                                    padding: const EdgeInsets.all(6.0),
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
                                  RecommendationsScreen.platformImgs[recom.platform],
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
                                Text(recom.accuracy),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.check),
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
    );
  }

  Widget _showNoRecommendation() {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 600),
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No recommendations at the moment!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
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