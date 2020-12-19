import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';

import'../screens/profile.dart';

import '../classes/searched_friends_class.dart';

import '../utils/platforms.dart' as platforms;

class FriendCard extends StatelessWidget {
  final Friends friend;
  final BuildContext context;
  final int i;
  final Animation animation;
  FriendCard(this.friend, this.context, this.i, this.animation);
  static const platformImgs = platforms.platformImgs;

  final Tween<Offset> _offSetTween = Tween(
    begin: Offset(1, 0),
    end: Offset.zero,
  );
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
                        //SizedBox(width: 20),
                        Flexible(
                          child: Padding(
                              padding: new EdgeInsets.only(
                                  left: 0.0, right: 6.0, top: 6.0, bottom: 6.0),
                              child: InkWell(
                                child: Text(
                                  friend.firstName + " " + friend.lastName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: ProfileScreen(
                                              handle: friend.stopStalkHandle)));
                                }
                              )),
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
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: Wrap(
                            spacing: 6.0,
                            runSpacing: 6.0,
                            children: List<Widget>.generate(
                                friend.handles.length, (int index) {
                              return InputChip(
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    FriendCard.platformImgs[
                                        friend.handles[index][0].toLowerCase()],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                label: Text(friend.handles[index][1]),
                                elevation:6,
                                onPressed: () {
                                  print('Handle got clicked');
                                },
                              );
                            }),
                          ),
                        ),
                      ),
                      RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 17.0, right: 17.0),
                        onPressed: () {}, //Add To Friends
                        color: Color(0xFF2542ff),
                        icon: Icon(Icons.add),
                        label: Text('Add to Friends'),
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
