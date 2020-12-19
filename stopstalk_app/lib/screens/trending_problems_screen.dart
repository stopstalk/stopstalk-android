import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/preloader.dart';
import '../widgets/trending_problems_card.dart';
import '../classes/problems_class.dart';
import '../classes/trendingProblems_class.dart';
import '../utils/api.dart';
import './login/login_screen.dart';

class TrendingProblemsScreen extends StatefulWidget {
  static const routeName = '/trending-problems';

  @override
  _TrendingProblemsScreenState createState() => _TrendingProblemsScreenState();
}

class _TrendingProblemsScreenState extends State<TrendingProblemsScreen> {
  List<Problems> gproblems = [];
  List<Problems> fproblems = [];

  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _animatedListKey2 =
      GlobalKey<AnimatedListState>();

  String getPlatform(String url) {
    if (url.contains('kenkoooo.com/') || url.contains('atcoder.jp/')) {
      return 'Atcoder';
    } else if (url.contains('codechef.com/')) {
      return 'Codechef';
    } else if (url.contains('codeforces.com/')) {
      return 'Codeforces';
    } else if (url.contains('hackerearth.com/')) {
      return 'Hackerearth';
    } else if (url.contains('hackerrank.com/')) {
      return 'Hackerrank';
    } else if (url.contains('spoj.com/')) {
      return 'Spoj';
    } else if (url.contains('acm.timus.ru/')) {
      return 'Timus';
    } else if (url.contains('uva.onlinejudge.org') ||
        url.contains('uhunt.felix-halim.net')) {
      return 'Uva';
    } else {
      return 'Other';
    }
  }

  Future<List<Problems>> _getTrendingProblems() async {
    var probs = await getGlobalTrendingprobs();
    if (probs == null) return [];
    List result = probs['problems'];
    for (int i = 0; i < result.length; i++) {
      Problems problem = Problems(
        id: result[i][0],
        problemName: result[i][1]['name'],
        totalSubmissions: result[i][1]['total_submissions'].toString(),
        users: result[i][1]['users'].length,
        problemUrl: result[i][1]['link'],
        platform: getPlatform(result[i][1]['link']),
      );

      gproblems.add(problem);
    }
    return gproblems;
  }

  Future<List<Problems>> _getTrendingFriendsProblems() async {
    var probs = await getFriendsTrendingprobs();
    if (probs == null) return [];
    List result = probs['problems'];
    for (int i = 0; i < result.length; i++) {
      Problems problem = Problems(
        id: result[i][0],
        problemName: result[i][1]['name'],
        totalSubmissions: result[i][1]['total_submissions'].toString(),
        users: result[i][1]['users'].length,
        problemUrl: result[i][1]['link'],
        platform: getPlatform(result[i][1]['link']),
      );

      fproblems.add(problem);
    }
    return fproblems;
  }

  Future<List<Problems>> myFuture;

  @override
  void initState() {
    myFuture = _getTrendingProblems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TrendingProblems args = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Trending Problems',
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.language),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'GLOBAL',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'FRIENDS',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
        drawer: AppDrawer(),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: myFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: AnimatedList(
                              key: _animatedListKey,
                              primary: true,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              initialItemCount: snapshot.data.length,
                              itemBuilder: (context, i, animation) {
                                return ProblemsCard(
                                    snapshot.data[i], context, i, animation);
                              },
                            )),
                      ],
                    ),
                  );
                } else {
                  return Preloader();
                }
              },
            ),
            Container(
              child: args.loggedin == true
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(
                                'assets/images/unauthorisedUser.png'),
                          ),
                          Text(
                            "Log in to view Trending Problems among your Friends",
                            style: TextStyle(
                                color: Color(0xFF2542ff), fontSize: 16.0),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0),
                          ),
                          RaisedButton(
                            elevation: 4,
                            color: Theme.of(context).buttonColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Sign In to StopStalk",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginPage.routeName);
                            },
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: FutureBuilder(
                        future: _getTrendingFriendsProblems(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      child: AnimatedList(
                                        key: _animatedListKey2,
                                        primary: true,
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        initialItemCount: snapshot.data.length,
                                        itemBuilder: (context, i, animation) {
                                          return ProblemsCard(snapshot.data[i],
                                              context, i, animation);
                                        },
                                      )),
                                ],
                              ),
                            );
                          } else {
                            return Preloader();
                          }
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
