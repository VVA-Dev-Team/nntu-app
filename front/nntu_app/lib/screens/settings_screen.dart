import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:provider/provider.dart';

// Настройки

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Настройки',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        backgroundColor:
            themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
      ),
      body: Container(
        color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Темная тема',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(themeModel.isDark
                            ? Icons.nightlight_round
                            : Icons.wb_sunny),
                        onPressed: () {
                          themeModel.isDark
                              ? themeModel.isDark = false
                              : themeModel.isDark = true;
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
