import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../widgets/app_drawer.dart';
import '../widgets/preloader.dart';
import '../classes/trendingProblems_class.dart';

class TrendingProblemsScreen extends StatefulWidget {
  static const routeName = '/trending-problems';

  @override
  _TrendingProblemsScreenState createState() => _TrendingProblemsScreenState();
}

class _TrendingProblemsScreenState extends State<TrendingProblemsScreen> {
  List<TrendingProblems> problems = [];

  Future<List<TrendingProblems>> _getTrendingProblems() async {
    for (int i = 1; i < 15; i++) {
      TrendingProblems problem = TrendingProblems(
        problemName: 'Special Permuatation',
        recentSubmissions: 10000 * i,
        users: 2000,
      );
      problems.add(problem);
    }
    return problems;
  }

  Future<List<TrendingProblems>> myFuture;

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
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  FutureBuilder(
                    future: myFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            ListView.builder(
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, i) {
                                return Table(
                                  columnWidths: {
                                    0: FixedColumnWidth(
                                        MediaQuery.of(context).size.width *
                                            0.4),
                                    1: FixedColumnWidth(
                                        MediaQuery.of(context).size.width *
                                            0.24),
                                    2: FixedColumnWidth(
                                        MediaQuery.of(context).size.width *
                                            0.15),
                                    3: FixedColumnWidth(
                                        MediaQuery.of(context).size.width *
                                            0.2),
                                  },
                                  border: TableBorder.all(
                                    color: Colors.black26,
                                    width: 1,
                                  ),
                                  children: [
                                    i != 0
                                        ? problemCard(
                                            snapshot.data[i], context, i)
                                        : TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                height: 60,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Center(
                                                    child: AutoSizeText(
                                                      "Problem Name",
                                                      maxLines:1,
                                                      minFontSize:12,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Container(
                                                height: 60,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Center(
                                                    child: AutoSizeText(
                                                      "Submission",
                                                      maxLines:1,
                                                      minFontSize:12,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Container(
                                                height: 60,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Center(
                                                    child: AutoSizeText(
                                                      "User",
                                                      maxLines:1,
                                                      minFontSize:12,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                                child: Container(
                                              width: 80,
                                            )),
                                          ])
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      } else {
                        return Preloader();
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }

  TableRow problemCard(TrendingProblems problem, BuildContext context, int i) {
    return TableRow(
      decoration: BoxDecoration(
        color: i % 2 == 0 ? Color(0XFFeeeeee) : Colors.white,
      ),
      children: [
        TableCell(
          child: Container(
            height: 55,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(problem.problemName)),
            ),
          ),
        ),
        TableCell(
          child: Container(
            height: 55,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('${problem.recentSubmissions}'),
              ),
            ),
          ),
        ),
        TableCell(
          child: Container(
            height: 55,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '${problem.users}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
        TableCell(
          child: Container(
            height: 55,
            child: Center(
              child: Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 12,
                    right: 12,
                  ),
                  child: RaisedButton(
                    elevation: 5,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    color: Color(0xFF0018ca),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 10,
                        ),
                        AutoSizeText(
                          'Todo',
                          maxLines: 1,
                          minFontSize: 7,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Added to todo problems"),
                          elevation: 10,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
