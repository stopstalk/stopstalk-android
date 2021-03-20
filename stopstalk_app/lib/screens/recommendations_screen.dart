import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/problems_card.dart';
import '../widgets/preloader.dart';

import '../classes/problems_class.dart';
import '../utils/api.dart';

class RecommendationsScreen extends StatefulWidget {
  static const routeName = '/recommendations';

  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  List<Problems> recom = [];
  bool flag = false;

  Future<List<Problems>> _getRecommendations() async {
    var resp = await getRecommendedProblems();
    if (resp["recommendations_length"] == 0) {
      flag = true;
      return [];
    }
    print(resp);
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
      else if(element["link"].contains('leetcode.com/')){
        platform='Leetcode';
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
          accuracy: (element["solved_submissions"] *
                      100.0 /
                      element["total_submissions"])
                  .toStringAsFixed(2) +
              "%",
          totalSubmissions: element["total_submissions"].toString(),
          tags: tags);
      recom.add(prob);
    });
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
        backgroundColor: Color(0xFF2542ff),
        title: Text(
          'Recommendations',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future: myF,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return flag != true
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProblemsCard(
                            snapshot.data[index], context, index);
                      },
                    )
                  : _showNoRecommendation();
            } else if (snapshot.hasError) {
              return Text(snapshot.error);
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(child: Preloader()),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _showNoRecommendation() {
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
