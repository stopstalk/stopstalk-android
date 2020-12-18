import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/problems_card.dart';
import '../classes/problems_class.dart';

class SearchedProblemsScreen extends StatefulWidget {
  static const routeName = '/searchedproblems';

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
  _SearchedProblemsScreenState createState() => _SearchedProblemsScreenState();
}

class _SearchedProblemsScreenState extends State<SearchedProblemsScreen> {
  List<Problems> searched = [];
  bool flag = false;

  final GlobalKey<AnimatedListState> _animatedListKey =
  GlobalKey<AnimatedListState>();

  Future<List<Problems>> _getSearchedProblems() async {
    for (int i = 1; i < 5; i++) {
      if (i % 2 == 0) {
        Problems prob = Problems(
            problemName: 'Special Permutation ',
            platform: 'Codechef',
            problemUrl: 'https://codeforces.com/contest/1454/problem/A',
            editorialUrl: 'https://codeforces.com/contest/1454/problem/B',
            totalSubmissions: '500',
            accuracy: '25%',
            tags: [
              'hard','easy','dp'
            ]
        );
        searched.add(prob);
      } else {
        Problems prob = Problems(
            problemName: 'Special Permutation Permutation',
            platform: 'Codeforces',
            problemUrl: 'https://codeforces.com/contest/1454/problem/A',
            editorialUrl: 'https://codeforces.com/contest/1454/problem/B',
            totalSubmissions: '500',
            accuracy: '25%',
            tags: [
              'hard','easy','dp','easy','dp','easy','dp','easy','dp','easy','dp'
            ]
        );
        searched.add(prob);
      }
    }
    searched.length == 0 ? flag = true : flag = false;
    return searched;
  }

  Future<List<Problems>> myF;

  @override
  void initState() {
    myF = _getSearchedProblems();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2542ff),
        title: Text(
          'Searched Problems',
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
                          return ProblemsCard(
                              snapshot.data[i], context, i);
                        },
                      )
                          : _showNoProblemsFound(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error);
                  } else {
                    return Text('No error and no data');
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        height: 62.0,
        width: 62.0,
        child: FittedBox(
          child: FloatingActionButton(child: Icon(Icons.search),
            backgroundColor: Color(0xFF0018ca),
            onPressed: (){
              Navigator.of(context)
                  .pop();
            },),
        ),
      ),
    );
  }
  Widget _showNoProblemsFound() {
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
              'No relevant problems found!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}