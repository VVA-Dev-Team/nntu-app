import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nntu_app/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class LessonsModel extends ChangeNotifier {
  int _weekNumber = 1;
  int get weekNumber => _weekNumber;

  void incrementCount() {
    _weekNumber++;
    loadSchedule();
  }

  void decrementCount() {
    if (_weekNumber > 1) {
      _weekNumber--;
    }
    loadSchedule();
  }

  void setWeekNumber(int week) {
    _weekNumber = week;
    loadSchedule();
  }

  int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  int getWeekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // var dateUtility = DateUtil();
      int week = getWeekNumber(picked);
      print(week);
      _weekNumber = (week - kStartLessonsWeek).abs();
      loadSchedule();
    }
  }

  List<List<Schedule>> _schedules = [[], [], [], [], [], [], []];
  List<List<Schedule>> get schedules => _schedules;

  LessonsModel() {
    _weekNumber = getWeekNumber(DateTime.now()) - kStartLessonsWeek;
    loadSchedule();
  }

  Future<void> loadSchedule() async {
    _schedules = [[], [], [], [], [], [], []];
    try {
      final prefs = await SharedPreferences.getInstance();
      var response = await http.get(Uri.parse(
          '${kDebugMode ? debugHostUrl : releaseHostUrl}api/schedule?group=${prefs.getString('userGroup')}&week_number=${_weekNumber % 2 == 0 ? -2 : -1}'));
      dynamic responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        for (int i = 0; i < responseData.length; i++) {
          for (int j = 0; j < responseData[i].length; j++) {
            var e = responseData[i][j];
            _schedules[i].add(Schedule(
                name: e['name'],
                type: e['type'],
                room: e['room'],
                startTime: e['startTime'],
                stopTime: e['stopTime'],
                day: e['day'],
                weeks: e['weeks'].cast<int>(),
                teacher: e['teacher'],
                comment: e['comment']));
          }
        }
      } else {
        _schedules = [[], [], [], [], [], [], []];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _schedules = [[], [], [], [], [], [], []];
    }
    notifyListeners();
  }
}

class Schedule {
  final String name;
  final String type;
  final String room;
  final int startTime;
  final int stopTime;
  final int day;
  final List<int> weeks;
  final String teacher;
  final String comment;

  Schedule({
    required this.name,
    required this.type,
    required this.room,
    required this.startTime,
    required this.stopTime,
    required this.day,
    required this.weeks,
    required this.teacher,
    required this.comment,
  });
}
