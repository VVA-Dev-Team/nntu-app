import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitModel extends ChangeNotifier {
  bool _inited = false;
  bool get inited => _inited;

  bool _showInstruction = true;
  bool get showInstruction => _showInstruction;

  InitModel() {
    initApp();
  }

  void initApp() async {
    if (await Permission.storage.request().isGranted) {
      _inited = true;

      final prefs = await SharedPreferences.getInstance();
      bool data = prefs.getBool('showInstruction') ?? true;
      print(data);
      if (data) {
        _showInstruction = true;
      } else {
        _showInstruction = false;
      }

      notifyListeners();
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  Future<void> setInstructionScreen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showInstruction', false);
    initApp();
  }
}
