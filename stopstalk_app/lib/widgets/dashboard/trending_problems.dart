import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../screens/trending_problems_screen.dart';
import '../../classes/trendingProblems_class.dart';

import '../../utils/auth.dart';

class TrendingProblemsDashboard extends StatefulWidget {

  @override
  _TrendingProblemsDashboardState createState() => _TrendingProblemsDashboardState();
}

class _TrendingProblemsDashboardState extends State<TrendingProblemsDashboard> {
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
                      flex: 2,
                      child: Text(
                        "Problem",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Recent Submissions",
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
                      flex: 4,
                      child: Text(
                        "Floor Number",
                        style: TextStyle(
                          color: Colors.red[900],
                          fontWeight: FontWeight.w400,
                          fontSize: 17.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "3894",
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
                        "2790",
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
              ),
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
                      flex: 4,
                      child: Text(
                        "Symmetric Matrix",
                        style: TextStyle(
                          color: Colors.green[900],
                          fontWeight: FontWeight.w400,
                          fontSize: 17.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "3953",
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
                        "2331",
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
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
          ),
          RaisedButton(
              elevation: 5,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Color(0xFF2542ff),
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
                  arguments: TrendingProblems(loggedin: null),
                );
              }),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
          ),
        ],
      ),
    );
  }
}
