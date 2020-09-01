import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';

import '../widgets/app_drawer.dart';
import '../classes/leaderboard.dart';

class LeaderBoardScreen extends StatelessWidget {
  static const routeName = '/leaderBoard';

  Future<List<LeaderBoard>> _getLeaderBoard() async {
    const url = "https://www.stopstalk.com/leaderboard.json";
    final response = await http.get(url);
    final jsonData = jsonDecode(response.body);
    List<LeaderBoard> users = [];
    for (var user in jsonData["users"]) {
      LeaderBoard person = LeaderBoard(
        name: user[0],
        stopstalkHandle: user[1],
        institute: user[2],
        stopstalkRating: user[3],
        perDayChanges: user[4],
        country: user[5],
        customUsers: user[6],
        rank: user[7],
      );
      users.add(person);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'LeaderBoard',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: FutureBuilder(
                        future: _getLeaderBoard(),
                        builder: (ctx, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (ctx, i) {
                                if (i == 0) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 25,
                                          ),
                                          child: AutoSizeText('Rank',
                                              maxLines: 1,
                                              minFontSize: 12,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                height: 2.0,
                                                fontSize: 15.2,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: AutoSizeText('Details',
                                            maxLines: 1,
                                            minFontSize: 12,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              height: 2.0,
                                              fontSize: 15.2,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: AutoSizeText('StopStalk Rating',
                                              maxLines: 1,
                                              minFontSize: 12,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                height: 2.0,
                                                fontSize: 15.2,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Card(
                                    elevation: 2.0,
                                    margin: EdgeInsets.all(7),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Text(
                                          '${snapshot.data[i - 1].rank}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      title: Text(
                                        snapshot.data[i].name,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.school,
                                                size: 15,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  ' ${snapshot.data[i - 1].institute}',
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      trailing: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          '${snapshot.data[i - 1].stopstalkRating}',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Text('this is the friends leaderboard page'),
            ),
          ],
        ),
      ),
    );
  }
}
