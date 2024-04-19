
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyDateUtils {
  static String getFormattedTime(
  {required BuildContext context,required  String time}){
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
}

//get last message time (used in chat user card)
static String getLastMessageTime(
  {required BuildContext context,required String time}){
  final DateTime sent  = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
  final DateTime now = DateTime.now();
  
  if(now.day == sent.day && now.month == sent.month && now.year == sent.year){
    return TimeOfDay.fromDateTime(sent).format(context);
  }
  return '${sent.day} ${_getMonth(sent)}';
  
}
  static String _getMonth(DateTime date){
    String monthName;
    switch (date.month) {
      case 1:  monthName = "Jan"; break;
      case 2:  monthName = "Feb"; break;
      case 3:  monthName = "Mar"; break;
      case 4:  monthName = "Apr"; break;
      case 5:  monthName = "May"; break;
      case 6:  monthName = "Jun"; break;
      case 7:  monthName = "Jul"; break;
      case 8:  monthName = "Aug"; break;
      case 9:  monthName = "Sept"; break;
      case 10: monthName = "Oct"; break;
      case 11: monthName = "Nov"; break;
      case 12: monthName = "Dec"; break;
      default: monthName = "Invalid month"; break;
    }
    return monthName;
  }
  }


