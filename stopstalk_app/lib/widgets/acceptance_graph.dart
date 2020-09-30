import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar.dart';
import 'package:heatmap_calendar/time_utils.dart';

class AcceptanceGraph extends StatelessWidget {
  final List<int> colorNum = [1, 5, 10, 15, 20, 25, 30, 35, 4, 18];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HeatMapCalendar(
        input: {
//            TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 36))):
//                8,
//            TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 35))):
//                20,
//            TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 33))):
//                20,
//            TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 34))):
//                20,
//            TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 32))):
//                20,
//            TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 31))):
//                10,
//            TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 30))):
//                20,
//            TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 29))): 5,
//            TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 9))): 5,

          for (int i = 0; i < 90; i++)
            if (i % 2 == 0)
              TimeUtils.removeTime(DateTime.now().subtract(Duration(days: i))):
              colorNum[i % 10]
            else if (i % 3 == 0)
              TimeUtils.removeTime(DateTime.now().subtract(Duration(days: i))):
              colorNum[i % 10]
            else
              TimeUtils.removeTime(DateTime.now().subtract(Duration(days: i))):
              colorNum[i % 10]
        },
        colorThresholds: {
          1: Color(0xff776fff),
          10: Color(0xff2542ff),
          30: Color(0xff0018ca),
        },
        weekDaysLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
        monthsLabels: [
          "",
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec",
        ],
        squareSize: 25.0,
        textOpacity: 0.3,
        labelTextColor: Colors.blueGrey,
        dayTextColor: Colors.white,
      ),
    );
  }
}
