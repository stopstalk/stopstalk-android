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

  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

  Future<List<Problems>> _getRecommendations() async {
    var resp = await getRecommendedProblems(context);
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
      Problems prob = Problems(
          id: element["id"],
          problemName: element["name"],
          platform: 'Codechef',
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              FutureBuilder(
                future: myF,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
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
                          : _showNoRecommendation(),
                    );
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
            ],
          ),
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
