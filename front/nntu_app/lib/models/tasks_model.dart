import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import "package:shared_preferences/shared_preferences.dart";
import "package:http/http.dart" as http;

class TasksModel extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  List<Task> _oldTasks = [];
  List<Task> get oldTasks => _oldTasks;

  List<int> _confirmedTasks = [];
  List<int> get confirmedTasks => _confirmedTasks;

  Future<void> getTasks() async {
    await getConfirmedTasks();

    _tasks = [];
    _oldTasks = [];

    final prefs = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(
        "${kDebugMode ? debugHostUrl : releaseHostUrl}api/tasks?group=${prefs.getString("userGroup")}"));
    dynamic responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      for (var i in responseData) {
        print('*' * 24);
        print(i['id']);
        print(_confirmedTasks.contains(i['id']));
        print(_confirmedTasks);
        print('*' * 24);
        if (DateTime.now()
            .isBefore(DateFormat('kk:mm – dd.MM.yyyy').parse(i['stopDate']))) {
          _tasks.add(Task(
            i['id'],
            i['title'],
            i['description'],
            i['lessonName'],
            i['priority'],
            i['stopDate'],
            i['addedByStudent'],
            _confirmedTasks.contains(i['id']) ? true : false,
          ));
        } else {
          _oldTasks.add(Task(
            i['id'],
            i['title'],
            i['description'],
            i['lessonName'],
            i['priority'],
            i['stopDate'],
            i['addedByStudent'],
            _confirmedTasks.contains(i['id']) ? true : false,
          ));
        }
      }
    } else {
      _tasks = [];
      _oldTasks = [];
    }

    notifyListeners();
  }

  Future<void> setTaskStatus(int id, bool status) async {
    _tasks[id].status = status;
    if (!_confirmedTasks.contains(_tasks[id].id) && status) {
      await saveConfirmedTask(_tasks[id].id);
    } else if (_confirmedTasks.contains(_tasks[id].id) && !status) {
      await deleteConfirmedTask(_tasks[id].id);
    }
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    var response = await http.delete(Uri.parse(
        "${kDebugMode ? debugHostUrl : releaseHostUrl}api/tasks?id=$id"));

    getTasks();
  }

  int _newId = 0;
  void setNewId(int val) {
    _newId = val;
  }

  String _newTitle = '';
  void setNewTitle(String val) {
    _newTitle = val;
  }

  String _newDescription = '';
  void setNewDescription(String val) {
    _newDescription = val;
  }

  String _newLessonName = '';
  void setNewLessonName(String val) {
    _newLessonName = val;
  }

  String _newPriority = 'Не срочное';
  String get newPriority => _newPriority;
  void setdefPriority(String val) {
    _newPriority = val;
  }

  void setNewPriority(String val) {
    _newPriority = val;
    notifyListeners();
  }

  String _newStopDate = 'не задано';
  String get newStopDate => _newStopDate;
  void setdefStopDate(String val) {
    _newStopDate = val;
  }

  bool valodateData(bool isEditor, int? index, BuildContext context) {
    if (isEditor) {
      if (tasks[index!].title == '') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Название не должно быть пустым',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        );
        return false;
      } else if (tasks[index].stopDate == 'не задано') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Дата окончания должна быть указана обязательно',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        );
        return false;
      } else {
        return true;
      }
    } else {
      if (_newTitle == '') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Название должно быть указано обязательно',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        );
        return false;
      } else if (_newStopDate == 'не задано') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Дата окончания должна быть указана обязательно',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        );
        return false;
      } else {
        return true;
      }
    }
  }

  Future<void> setNewStopDate(BuildContext context) async {
    final themeModel = Provider.of<ThemeModel>(context, listen: false);
    final date = await showDatePicker(
        locale: const Locale("ru", "RU"),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: kButtonColor, // header background color
                onPrimary: kTextColorDark, // header text color
                onSurface: themeModel.isDark
                    ? kTextColorDark
                    : kTextColorLight, // body text color
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    final time = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
                hourMinuteColor: kButtonColor,
                hourMinuteTextColor:
                    themeModel.isDark ? kTextColorDark : kTextColorLight,
                dialTextColor:
                    themeModel.isDark ? kTextColorDark : kTextColorLight,
                entryModeIconColor: kButtonColor,
                backgroundColor: themeModel.isDark
                    ? kSecondaryColorDark
                    : kSecondaryColorLight),
            primaryColor: Colors.cyan,
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (date != null && time != null) {
      final newDate = DateTime(
          DateTime.now().year, date.month, date.day, time.hour, time.minute);
      _newStopDate = DateFormat('kk:mm – dd.MM.yyyy').format(newDate);
    }
    notifyListeners();
  }

  Future<void> addTask() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString("userGroup") != null &&
        prefs.getString("userKey") != null) {
      var request = http.MultipartRequest('POST',
          Uri.parse('${kDebugMode ? debugHostUrl : releaseHostUrl}api/tasks/'));
      request.fields.addAll({
        'group': prefs.getString("userGroup")!,
        'title': _newTitle,
        'description': _newDescription,
        'lessonName': _newLessonName,
        'priority': _newPriority,
        'stopDate': _newStopDate,
        'addedByStudent': prefs.getString("userKey")!,
      });
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        getTasks();
      }
    } else {
      print('error');
    }
    _newStopDate = 'не задано';
    _newPriority = 'Не срочное';
  }

  Future<void> editTask(int id) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString("userGroup") != null &&
        prefs.getString("userKey") != null) {
      var request = http.MultipartRequest('PUT',
          Uri.parse('${kDebugMode ? debugHostUrl : releaseHostUrl}api/tasks/'));
      request.fields.addAll({
        'id': '$id',
        'group': prefs.getString("userGroup")!,
        'title': _newTitle,
        'description': _newDescription,
        'lessonName': _newLessonName,
        'priority': _newPriority,
        'stopDate': _newStopDate,
        'addedByStudent':
            '${prefs.getString("userName")!} ${prefs.getString("userSername")!}',
      });
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        getTasks();
      }
    } else {
      print('error');
    }
    _newStopDate = 'не задано';
    _newPriority = 'Не срочное';
  }

  //#region Confirmed Tasks

  Future<void> getConfirmedTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('confirmedTasks');
    if (data != null) {
      final jsonData = json.decode(data);
      jsonData.map((e) => {
            _confirmedTasks.add(e['id']),
          });
    } else {
      saveConfirmedTasks();
    }
  }

  Future<void> saveConfirmedTasks() async {
    print(_confirmedTasks);
    var confirmedTasksForSave = [];
    for (var element in _confirmedTasks) {
      if (_tasks.contains(element)) {
        confirmedTasks.add(element);
      }
    }
    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(confirmedTasksForSave);
    await prefs.setString('confirmedTasks', jsonData);
  }

  Future<void> saveConfirmedTask(int id) async {
    _confirmedTasks.add(id);
    await saveConfirmedTasks();
  }

  Future<void> deleteConfirmedTask(int id) async {
    _confirmedTasks.removeWhere((element) => element == id);
    await saveConfirmedTasks();
  }

  //#endregion

}

class Task {
  final int id;
  final String title;
  final String description;
  final String lessonName;
  final String priority;
  final String stopDate;
  final String addedByStudent;
  bool status;

  Task(this.id, this.title, this.description, this.lessonName, this.priority,
      this.stopDate, this.addedByStudent, this.status);
}
