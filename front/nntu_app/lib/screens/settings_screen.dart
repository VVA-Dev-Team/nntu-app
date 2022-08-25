import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
import 'package:provider/provider.dart';

// Настройки

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return ScreenScaffold(
      disableNavbar: true,
      title: 'Настройки',
      body: Container(
        color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Темная тема',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const Spacer(),
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
