import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/widgets/screen_hader.dart';

// Настройки

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Column(
        children: [
          ScreenHader(title: 'Настройки'),
        ],
      ),
    );
  }
}
