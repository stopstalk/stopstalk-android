import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable/expandable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../fragments/my_flutter_app_icons.dart';
import '../classes/problems_class.dart';

import '../utils/platforms.dart' as platforms;
import '../utils/api.dart';
import '../utils/auth.dart';

class ProblemsCard extends StatelessWidget {
  final Problems recom;
  final BuildContext context;
  final int i;

  ProblemsCard(
    this.recom,
    this.context,
    this.i,
  );

  static const platformImgs = platforms.platformImgs;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Column(children: [
      Expandable(
        collapsed: ExpandableButton(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              color: Color(0XFFeeeeee),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          recom.platform != null
                              ? GestureDetector(
                                  onTap: () {
                                    _launchURL(recom.problemUrl);
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xFF2542ff),
                                    child: CircleAvatar(
                                      backgroundColor: Color(0XFFeeeeee),
                                      radius: 28,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.asset(
                                          ProblemsCard.platformImgs[
                                              recom.platform.toLowerCase()],
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ))
                              : SizedBox(width: 0),
                          //SizedBox(width: 20),
                          Flexible(
                            flex: 2,
                            child: Padding(
                                padding: new EdgeInsets.only(
                                    left: 0.0,
                                    right: 6.0,
                                    top: 6.0,
                                    bottom: 6.0),
                                child: InkWell(
                                  child: Text(
                                    recom.problemName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  onTap: () => _launchURL(
                                      "https://www.stopstalk.com/problems?problem_id=${recom.id}"),
                                )),
                          ),
                          Flexible(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.externalLinkAlt,
                                size: 15,
                              ),
                              onPressed: () => _launchURL(
                                  "https://www.stopstalk.com/problems?problem_id=${recom.id}"),
                            ),
                          ),
                        ]),
                    Divider(
                      color: Colors.grey,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                recom.accuracy + " Accuracy",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[800]),
                              ), //Icon(FontAwesomeIcons.bullseye),
                              Text(
                                recom.totalSubmissions + " Submissions",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[800]),
                              ), //Icon(Icons.arrow_upward_rounded),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RaisedButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  left: 17.0,
                                  right: 17.0),
                              onPressed: () => _launchURL(recom.editorialUrl),
                              color: Color(0xFF2542ff),
                              icon: Icon(MyFlutterApp.contract),
                              label: Text('Editorials'),
                              textColor: Colors.white,
                            ),
                            RaisedButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  left: 17.0,
                                  right: 17.0),
                              onPressed: () => _addToTodo(context, recom),
                              color: Color(0xFF2542ff),
                              icon: Icon(Icons.add),
                              label: Text('TODO'),
                              textColor: Colors.white,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ), //new card
            ),
          ),
        ),
        expanded: Column(children: [
          ExpandableButton(
            // <-- Collapses when tapped on
            child: Container(
              padding: const EdgeInsets.all(4.0),
              width: double.infinity,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                color: Color(0XFFeeeeee),
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  child: Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children:
                        List<Widget>.generate(recom.tags.length, (int index) {
                      return Chip(
                        label: Text(recom.tags[index]),
                      );
                    }),
                  ),
                ),
              ),
            ),
          )
        ]),
      )
    ]));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text('No editorial is available'),
            elevation: 10,
            duration: Duration(seconds: 2)),
      );
    }
  }
}

_addToTodo(BuildContext context, Problems problem) async {
  bool isLoggedin = await isAuthenticated();
  if (!isLoggedin)
    _showToLogin(context);
  else {
    var resp = await addTodoUsingId(problem.id.toString());
    Scaffold.of(context).showSnackBar(
      SnackBar(
          content: Text(resp.toString()),
          elevation: 10,
          duration: Duration(seconds: 2)),
    );
  }
}

void _showToLogin(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          content: Text("Login to add Todo"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: const Text("LOGIN"),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("CANCEL"),
            ),
          ],
        ));
