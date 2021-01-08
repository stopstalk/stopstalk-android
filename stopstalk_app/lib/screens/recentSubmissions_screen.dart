import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/recentCard.dart';
import '../classes/recent_submissions_class.dart';

import '../utils/api.dart';
import '../utils/platforms.dart' as platforms;

import '../widgets/preloader.dart';

class RecentSubmissionsScreen extends StatefulWidget {
  static const routeName = '/recentsubmissions';
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
  _RecentSubmissionsScreenState createState() => _RecentSubmissionsScreenState();
}

class _RecentSubmissionsScreenState extends State<RecentSubmissionsScreen> {
  List<Recent> recents = [];

  bool flag = false;

  final GlobalKey<AnimatedListState> _animatedListKey =
  GlobalKey<AnimatedListState>();

  Future<List<Recent>> _getRecentSubmissions() async {
    for (int i = 1; i < 5; i++) {
      if (i % 2 == 0) {
        Recent rec = Recent(
            problemName: 'Special Permutation ',
            platform: 'Codechef',
            stopStalkUrl: 'https://codeforces.com/contest/1454/problem/A',
            name: 'Sandesh Singh',
            problemNameStopStalkUrl: 'https://codeforces.com/contest/1454/problem/B',
            date: '06/01/2021',
            id:'123',
            status: true
        );
        recents.add(rec);
      } else {
        Recent rec = Recent(
            problemName: 'Special Permutation ',
            platform: 'Codeforces',
            stopStalkUrl: 'https://codeforces.com/contest/1454/problem/A',
            name: 'Sandesh',
            problemNameStopStalkUrl: 'https://codeforces.com/contest/1454/problem/B',
            date: '06/01/2021',
            id:'123',
            status: false
        );
        recents.add(rec);
      }
    }
    recents.length == 0 ? flag = true : flag = false;
    return recents;
  }

  Future<List<Recent>> myF;

  @override
  void initState() {
    myF = _getRecentSubmissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2542ff),
        title: Text(
          'Recent Friend Submissions',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: myF,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: flag != true
                          ? AnimatedList(
                        key: _animatedListKey,
                        primary: true,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        initialItemCount: snapshot.data.length,
                        itemBuilder: (context, i, animation) {
                          return RecentCard(
                              snapshot.data[i], context, i);
                        },
                      )
                          : _showNoSubmissionsFound(),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          } else {
            return Center(child: Preloader());
          }
        },
      ),
    );
  }

  Widget _showNoSubmissionsFound() {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 600),
      child: Center(
        child: Image(
          image: AssetImage('assets/images/noResult.png'),
        ),
      ),
    );
  }
}
