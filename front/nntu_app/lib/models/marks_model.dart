import "dart:convert";

import "package:flutter/material.dart";
import "package:nntu_app/constants.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:http/http.dart" as http;

class MarksModel extends ChangeNotifier {
  MarksModel() {
    getMarks();
  }

  bool _initLoading = true;
  bool get initLoading => _initLoading;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isError = false;
  bool get isError => _isError;

  int _semestersCount = 1;
  int get semestersCount => _semestersCount;

  int _selectedSemester = 1;
  int get selectedSemester => _selectedSemester;

  void setSemester(int i) {
    _selectedSemester = i;
    notifyListeners();
  }

  MarksData _marks = MarksData(semesters: []);
  MarksData get marks => _marks;

  Stat _stat = Stat(predmets: [], average: '0', term: []);
  Stat get stat => _stat;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> getMarks() async {
    _isLoading = true;
    _isError = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();

    // try {
    var response = await http.get(Uri.parse(
        "${kDebugMode ? debugHostUrl : releaseHostUrl}api/marks?last_name=${prefs.getString("userSername")}&first_name=${prefs.getString("userName")}&otc=${prefs.getString("userPatronymic")}&n_zach=${prefs.getString("userKey")}&learn_type=${prefs.getString("userType")}"));
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      
      _semestersCount = responseData["marks"].length;
      _marks = MarksData(semesters: [
        for (var e in responseData["marks"])
          Semester(marks: [
            for (var x in e)
              Mark(
                predmet: x["predmet"],
                kn1: ControllWeek(
                    mark: '${x["kn1"]["mark"] ?? ''}',
                    leave: '${x["kn1"]["leave"] ?? ''}'),
                kn2: ControllWeek(
                    mark: '${x["kn2"]["mark"] ?? ''}',
                    leave: '${x["kn1"]["leave"] ?? ''}'),
                session: x["session"],
                typeOfAttestation: x["typeOfAttestation"],
              ),
          ])
      ]);

      List<StatPredmet> newStatPregments = [];

      for (var key in responseData['stat']['predmets'].keys) {
        newStatPregments.add(StatPredmet(
            name: key, marks: responseData['stat']['predmets'][key]));
      }
      _stat = Stat(
          predmets: newStatPregments,
          average: responseData['stat']['average'],
          term: responseData['stat']['term']);
    } else {
      _isError = true;
      _marks = MarksData(semesters: [Semester(marks: [])]);
      _semestersCount = 1;
      _selectedSemester = 1;
      _errorMessage = 'Пользователь не найден';
    }
    // } catch (e) {
    //   _isError = true;
    //   _errorMessage = '$e';
    // }

    _isLoading = false;
    _initLoading = false;

    notifyListeners();
  }
}

class Stat {
  final List<StatPredmet> predmets;
  final String average;
  final List<dynamic> term;
  Stat({required this.predmets, required this.average, required this.term});
}

class StatPredmet {
  final String name;
  final List<dynamic> marks;
  StatPredmet({required this.name, required this.marks});
}

class MarksData {
  final List<Semester> semesters;

  MarksData({required this.semesters});
}

class Semester {
  final List<Mark> marks;

  Semester({required this.marks});
}

class Mark {
  final String predmet;
  final ControllWeek kn1;
  final ControllWeek kn2;
  final String session;
  final String typeOfAttestation;

  Mark(
      {required this.predmet,
      required this.kn1,
      required this.kn2,
      required this.session,
      required this.typeOfAttestation});
}

class ControllWeek {
  final String mark;
  final String leave;
  ControllWeek({required this.mark, required this.leave});
}
