import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdditionallyModel extends ChangeNotifier {
  AdditionallyModel() {
    loadData();
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _edited = false;
  bool get edited => _edited;
  void setEdited(bool status) {
    _edited = status;
    notifyListeners();
  }

  String _userName = '';
  String get userName => _userName;
  void setUserName(String data) {
    _userName = data;
  }

  String _userSername = '';
  String get userSername => _userSername;
  void setUserSername(String data) {
    _userSername = data;
  }

  String _userPatronymic = '';
  String get userPatronymic => _userPatronymic;
  void setUserPatronymic(String data) {
    _userPatronymic = data;
  }

  String _userGroup = '';
  String get userGroup => _userGroup;
  void setUserGroup(String data) {
    _userGroup = data;
  }

  String _userType = '';
  String get userType => _userType;
  void setUserType(String data) {
    _userType = data;
  }

  String _userKey = '';
  String get userKey => _userKey;
  void setUserKey(String data) {
    _userKey = data;
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userName') != null &&
        prefs.getString('userSername') != null &&
        prefs.getString('userPatronymic') != null &&
        prefs.getString('userGroup') != null &&
        prefs.getString('userType') != null &&
        prefs.getString('userKey') != null) {
      _userName = prefs.getString('userName') ?? '';
      _userSername = prefs.getString('userSername') ?? '';
      _userPatronymic = prefs.getString('userPatronymic') ?? '';
      _userGroup = prefs.getString('userGroup') ?? '';
      _userType = prefs.getString('userType') ?? '';
      _userKey = prefs.getString('userKey') ?? '';
    }
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
    await prefs.setString('userSername', userSername);
    await prefs.setString('userPatronymic', userPatronymic);
    await prefs.setString('userGroup', userGroup);
    await prefs.setString('userType', userType);
    await prefs.setString('userKey', userKey);
    loadData();
  }

  Future<void> removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    await prefs.remove('userSername');
    await prefs.remove('userPatronymic');
    await prefs.remove('userGroup');
    await prefs.remove('userType');
    await prefs.remove('userKey');
    loadData();
  }
}
