import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/preloader.dart';
import '../widgets/trending_problems_card.dart';

import '../classes/problems_class.dart';

import '../utils/api.dart';

class TrendingProblemsScreen extends StatefulWidget {
  static const routeName = '/trending-problems';

  @override
  _TrendingProblemsScreenState createState() => _TrendingProblemsScreenState();
}

class _TrendingProblemsScreenState extends State<TrendingProblemsScreen> {
  List<Problems> problems = [];
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

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
          problemUrl: result[i][1]['link']);
      problems.add(problem);
    }
    return problems;
  }

  Future<List<Problems>> myFuture;

  @override
  void initState() {
    myFuture = _getTrendingProblems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Container(),
          ],
        ),
      ),
    );
  }
}
