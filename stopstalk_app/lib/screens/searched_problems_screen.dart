import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/problems_card.dart';
import '../classes/problems_class.dart';

import '../utils/api.dart';
import '../utils/platforms.dart' as platforms;

import '../widgets/preloader.dart';

class SearchedProblemsScreen extends StatefulWidget {
  static const routeName = '/searchedproblems';
  final Map<String, String> parameters;
  static const platformImgs = platforms.platformImgs;
  const SearchedProblemsScreen({Key key, this.parameters}) : super(key: key);

  @override
  _SearchedProblemsScreenState createState() => _SearchedProblemsScreenState();
}

class _SearchedProblemsScreenState extends State<SearchedProblemsScreen> {
  List<Problems> searched = [];
  bool flag = false;

  final GlobalKey<AnimatedListState> _animatedListKey =
  GlobalKey<AnimatedListState>();

  Future<List<Problems>> _getSearchedProblems() async {
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
      Problems prob = Problems(
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
                          : _showNoProblemsFound(),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          } else {
            return Center(child: PreloaderDualRing());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        height: 62.0,
        width: 62.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.search),
            backgroundColor: Color(0xFF0018ca),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  Widget _showNoProblemsFound() {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 600),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
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
