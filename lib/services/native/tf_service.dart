import 'package:intl/intl.dart';

Map<int, String> monthName = {
  1: "Jan",
  2: "Feb",
  3: "Mar",
  4: "Apr",
  5: "May",
  6: "Jun",
  7: "Jul",
  8: "Aug",
  9: "Set",
  10: "Oct",
  11: "Nov",
  12: "Dec",
};

String formatdateTime(DateTime dateTime) {
  DateTime local = dateTime.toLocal();
  String paddedDate = local.day.toString().padLeft(2, "0");
  String month = monthName[local.month];
  String time = DateFormat.jm().format(local).padLeft(8, "0");
  return paddedDate + " " + month + "T" + time;
}
