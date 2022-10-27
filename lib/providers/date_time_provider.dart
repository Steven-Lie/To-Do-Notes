import 'package:flutter/material.dart';

class DateTimeProvider with ChangeNotifier {
  DateTime _date = DateTime.now();
  DateTime get date => _date;

  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay get time => _time;

  datePicked(DateTime? date) {
    _date = date!;
    notifyListeners();
  }

  timePicked(TimeOfDay? time) {
    _time = time!;
    notifyListeners();
  }

  resetDateAndTime() {
    _date = DateTime.now();
    _time = TimeOfDay.now();
  }

  editDate(DateTime? date) {
    _date = date!;
  }

  editTime(TimeOfDay? time) {
    _time = time!;
  }
}
