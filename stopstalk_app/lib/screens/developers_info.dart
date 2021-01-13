import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/app_drawer.dart';

class DevelopersInfo extends StatelessWidget {
  static const routeName = '/developers-info';

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Developer's Info",
          textAlign: TextAlign.center,
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0, left: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Made with ",
                  style: TextStyle(fontSize: 22.0, color: Color(0xFF2542ff),),
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.red.shade600,
                  size: 25.0,
                ),
                Text(
                  " by",
                  style: TextStyle(fontSize: 22.0, color: Color(0xFF2542ff),),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 8.0),),
            Image(
              image: AssetImage('assets/images/devlupLabs1.png'),
            ),
            Padding(padding: EdgeInsets.only(top: 8.0),),
            Text(
              "Open Source Community of IIT Jodhpur",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
            ),
            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 22.0,
                color: Color(0xFF2542ff),
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.mail,
                    color: Color(0xFF2542ff),
                    size: 32.0,
                  ),
                  onPressed:(){
                    _launchURL("mailto:opensourceiitj@gmail.com");
                  }
                ),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.facebookSquare,
                      color: Color(0xFF2542ff),
                      size: 28.0,
                    ),
                    onPressed:(){
                      _launchURL("https://www.facebook.com/devluplabs/");
                    }
                ),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.instagram,
                      color: Color(0xFF2542ff),
                      size: 28.0,
                    ),
                    onPressed:(){
                      _launchURL("https://www.instagram.com/devluplabs/");
                    }
                ),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.github,
                      color: Color(0xFF2542ff),
                      size: 28.0,
                    ),
                    onPressed:(){
                      _launchURL("https://github.com/devlup-labs");
                    }
                ),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.linkedin,
                      color: Color(0xFF2542ff),
                      size: 28.0,
                    ),
                    onPressed:(){
                      _launchURL("https://www.linkedin.com/company/devlup-labs/");
                    }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
