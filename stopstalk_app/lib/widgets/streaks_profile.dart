import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Streaks extends StatelessWidget {
  final String heading;
  final String subtitle1;
  final String subtitle2;
  final int value1;
  final int value2;

  Streaks({
    this.heading,
    this.subtitle1,
    this.subtitle2,
    this.value1,
    this.value2,
  });

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
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: Colors.grey,
              offset: Offset(0.0, 2.0),
            ),
          ],
          color: Color(0XFFeeeeee),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                heading,
                minFontSize: 10,
                style: contentTextStyle,
              ),
              Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AutoSizeText(
                    subtitle1,
                    minFontSize: 8,
                    style: titleTextStyle,
                  ),
                  AutoSizeText(
                    subtitle2,
                    minFontSize: 8,
                    style: titleTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AutoSizeText(
                    '$value1',
                    minFontSize: 8,
                    style: contentTextStyle,
                  ),
                  AutoSizeText(
                    '$value2',
                    minFontSize: 8,
                    style: contentTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
