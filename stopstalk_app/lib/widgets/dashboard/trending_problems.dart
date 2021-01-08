import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/trending_problems_screen.dart';
import '../../classes/trendingProblems_class.dart';
import '../../utils/auth.dart';
import '../../utils/api.dart';
import '../../classes/problems_class.dart';
import '../preloader.dart';

class TrendingProblemsDashboard extends StatefulWidget {
  @override
  _TrendingProblemsDashboardState createState() =>
      _TrendingProblemsDashboardState();
}

class _TrendingProblemsDashboardState extends State<TrendingProblemsDashboard> {
  List<Problems> gproblems = [];

  Future<List<Problems>> _getTrendingProblems() async {
    var probs = await getGlobalTrendingprobs();
    if (probs == null) return [];
    List result = probs['problems'];
    for (int i = 0; i < 3; i++) {
      Problems problem = Problems(
          id: result[i][0],
          problemName: result[i][1]['name'],
          totalSubmissions: result[i][1]['total_submissions'].toString(),
          users: result[i][1]['users'].length,
          problemUrl: result[i][1]['link']);
      gproblems.add(problem);
    }
    return gproblems;
  }

  dynamic _userData;

  void setUser() async {
    var user = await getCurrentUser();
    setState(() => _userData = user);
  }

  @override
  void initState() {
    setUser();
    super.initState();
  }

  Future<List<Problems>> myFuture;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffeeeeee),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.grey,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          Text(
            "Trending Problems",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Problem Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          "Recent",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Users",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Submissions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: FutureBuilder(
                  future: _getTrendingProblems(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.length);
                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              child: ListView.builder(
                                primary: true,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, i) {
                                  return TrendingProbDashboardCard(
                                      snapshot.data[i], context);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Preloader();
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: RaisedButton(
                    elevation: 5,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Theme.of(context).buttonColor,
                    child: AutoSizeText(
                      'View All',
                      maxLines: 1,
                      minFontSize: 7,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        TrendingProblemsScreen.routeName,
                        arguments: TrendingProblems(
                            loggedin: _userData != null ? false : true),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget TrendingProbDashboardCard(Problems prob, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.0),
          ),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () => _launchURL(prob.problemUrl),
              child: Text(
                prob.problemName,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${prob.totalSubmissions}",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${prob.users}",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String proburl) async {
    var url = proburl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
