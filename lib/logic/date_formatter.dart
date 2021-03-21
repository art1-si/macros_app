import 'dart:math';

import 'package:intl/intl.dart';

String dateFormatted() {
  var now = DateTime.now();
  var past = DateTime.daysPerWeek;
  print(past);
  var formatter = DateFormat('EEEE yyyy-MM-dd hh:mm');
  String formatted = formatter.format(now);

  return formatted;
}

String dateFormattedToDays() {
  var now = DateTime.now();

  var formatter = DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(now);

  return formatted;
}

double roundDouble(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
