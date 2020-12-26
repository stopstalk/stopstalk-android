import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../classes/problems_class.dart';

import '../utils/api.dart';
import '../utils/auth.dart';
import '../utils/platforms.dart' as platforms;

class ProblemsCard extends StatelessWidget {
  final Problems recom;
  final BuildContext context;
  final int i;
  final Animation animation;

  ProblemsCard(
    this.recom,
    this.context,
    this.i,
    this.animation,
  );

  final Tween<Offset> _offSetTween = Tween(
    begin: Offset(1, 0),
    end: Offset.zero,
  );
  static const platformImgs = platforms.platformImgs;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: _offSetTween.animate(animation),
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child:Image.asset(
                                    ProblemsCard.platformImgs[
                                        recom.platform.toLowerCase()],
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )))
                          : SizedBox(width: 0),
                      Flexible(
                        flex: 2,
                        child: Padding(
                            padding: new EdgeInsets.only(
                                left: 0.0, right: 6.0, top: 6.0, bottom: 6.0),
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
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.externalLinkAlt,
                            size: 15,
                          ),
                          onPressed: () => _launchURL(
                              "https://www.stopstalk.com/problems?problem_id=${recom.id}"),
                        ),
                      ),
                    ],
                  ),
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
                              "In " + recom.users.toString() + " Todos",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[800]),
                            ),
                            Text(
                              recom.totalSubmissions + " Submissions",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 17.0, right: 17.0),
                        onPressed: () => _addToTodo(context, recom),
                        color: Color(0xFF2542ff),
                        icon: Icon(Icons.add),
                        label: Text('TODO'),
                        textColor: Colors.white,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ), //new card
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
