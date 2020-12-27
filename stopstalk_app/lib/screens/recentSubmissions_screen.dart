import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/recent.dart';
import '../classes/recent_submissions_class.dart';

import '../utils/api.dart';
import '../utils/platforms.dart' as platforms;

import '../widgets/preloader.dart';

class RecentSubmissionsScreen extends StatelessWidget {
  static const routeName = '/recentsubmissions';
  final Map<String, String> parameters;
  static const platformImgs = platforms.platformImgs;
  //const RecentSubmissionsScreen({Key key, this.parameters}) : super(key: key);

  List<Recent> recents = [];
  bool flag = false;

  final GlobalKey<AnimatedListState> _animatedListKey =
  GlobalKey<AnimatedListState>();

  Future<List<Recent>> _getSearchedProblems() async {
    var resp = await getSearchProblems(widget.parameters);
    if (resp == null) return [];
    var result = resp["problems"];

    result.forEach((element) {
      var tags = element["tags"]
          .replaceAll(']', '')
          .replaceAll('[', '')
          .replaceAll('u', '')
          .split(',');
      var platform;
      if(element["link"].contains('kenkoooo.com/') || element["link"].contains('atcoder.jp/')){
        platform='Atcoder';
      }
      else if(element["link"].contains('codechef.com/')){
        platform='Codechef';
      }
      else if(element["link"].contains('codeforces.com/')){
        platform='Codeforces';
      }
      else if(element["link"].contains('hackerearth.com/')){
        platform='Hackerearth';
      }
      else if(element["link"].contains('hackerrank.com/')){
        platform='Hackerrank';
      }
      else if(element["link"].contains('spoj.com/')){
        platform='Spoj';
      }
      else if(element["link"].contains('acm.timus.ru/')){
        platform='Timus';
      }
      else if(element["link"].contains('uva.onlinejudge.org') || element["link"].contains('uhunt.felix-halim.net')){
        platform='Uva';
      }
      else{
        platform='Other';
      }
      Recent prob = Recent(
          id: element["id"],
          problemName: element["name"],
          platform: platform,
          problemUrl: element["link"],
          editorialUrl: element["editorial_link"],
          totalSubmissions: element["total_submissions"].toString(),
          accuracy: (element["solved_submissions"] *
              100.0 /
              element["total_submissions"])
              .toStringAsFixed(2) +
              "%",
          tags: tags);
      searched.add(prob);
    });
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
                          return ProblemsCard(
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
