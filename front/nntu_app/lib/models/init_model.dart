import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class InitModel extends ChangeNotifier {
  bool _inited = false;
  bool get inited => _inited;

  InitModel() {
    initApp();
  }

  void initApp() async {
    if (await Permission.storage.request().isGranted) {
      _inited = true;
      notifyListeners();
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
}
