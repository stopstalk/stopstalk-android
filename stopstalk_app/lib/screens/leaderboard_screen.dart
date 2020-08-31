import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                    'Global',
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
                    'Friends',
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
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 18,
                          ),
                          child: Text('Rank',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                height: 3.0,
                                fontSize: 15.2,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      Expanded(
                        child: Text('Details',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              height: 3.0,
                              fontSize: 15.2,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: Text('StopStalk Rating',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                height: 3.0,
                                fontSize: 15.2,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: FutureBuilder(
                        future: _getLeaderBoard(),
                        builder: (ctx, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (ctx, i) {
                                return Card(
                                  elevation: 3.0,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      child: Text(
                                        '${snapshot.data[i].rank}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    title: Text(
                                      snapshot.data[i].name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: '',
                                            style: TextStyle(
                                              color: Colors.black,

                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Institute',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    height: 2,
                                                  )),
                                              TextSpan(
                                                text:
                                                    ' ${snapshot.data[i].institute}',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.black12,
                                      ),
                                      child: Text(
                                        '${snapshot.data[i].stopstalkRating}',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
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
            )
          ],
        ),
      ),
    );
  }
}
