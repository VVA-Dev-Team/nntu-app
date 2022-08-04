import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nntu_app/constants.dart';

Future<dynamic> getDataGetRequest(String apiUrl, BuildContext context) async {
  try {
    var response = await http
        .get(Uri.parse('${kDebugMode ? debugHostUrl : releaseHostUrl}$apiUrl'));
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Неверный ответ от сервера'),
              content:
                  Text('Код ошибки: ${response.statusCode}\n${response.body}'),
            );
          });
      return 'error';
    }
  } catch (e) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ошибка запроса'),
            content: Text('$e'),
          );
        });
    return 'error';
  }
}
