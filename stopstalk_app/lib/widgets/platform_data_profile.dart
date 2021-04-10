import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePlatformData extends StatelessWidget {
  final data;

  ProfilePlatformData(this.data);

  TextStyle get titleTextStyle => TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      );

  TextStyle get contentTextStyle => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.height * 0.3
            : MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0XFFeeeeee),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: Colors.grey,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.13,
              child: Image.asset(this.data['img']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Accuracy",
                    style: titleTextStyle,
                  ),
                  Text(
                    '${this.data['accuracy']}%',
                    style: contentTextStyle,
                  ),
                  SizedBox(
                    height: 1.5,
                    child: new Center(
                      child: new Container(
                        width: MediaQuery.of(context).size.width * 0.17,
                        height: 1.5,
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  Text(
                    "Solved",
                    style: titleTextStyle,
                  ),
                  Text(
                    '${this.data['solved']}',
                    style: contentTextStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Widget> listPlatform(mapPayload) {
  List<Widget> sites = [];
  //if (mapPayload == null) return [Text("No Handels Available Please Add them")];
  mapPayload.forEach((key, value) => sites.add(ProfilePlatformData(value)));
  return sites;
}
