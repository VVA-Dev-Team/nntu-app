import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nntu_app/constants.dart';

class PushNotificationService {
  Future initialise() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();

    if (kDebugMode) {
      print(fcmToken);
    }

    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {})
        .onError((err) {});
  }
}
