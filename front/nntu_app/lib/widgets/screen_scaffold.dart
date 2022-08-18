import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/models/navigation_model.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class ScreenScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final bool disableAppbar;
  const ScreenScaffold(
      {Key? key,
      required this.body,
      required this.title,
      this.actions,
      this.disableAppbar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final navigationModel = Provider.of<NavigationModel>(context);
    return Scaffold(
      appBar: !disableAppbar
          ? AppBar(
              title: Text(
                title,
                style: GoogleFonts.getFont(
                  'Exo 2',
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: actions,
            )
          : null,
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            themeModel.isDark ? kSecondaryColorDark : kSecondaryColorLight,
        currentIndex: navigationModel.selectedPage,
        selectedItemColor: kButtonColor,
        unselectedItemColor:
            themeModel.isDark ? kTextColorDark : kTextColorLight,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        onTap: (index) {
          navigationModel.changePage(index);
        },
        items: navigationModel
            .getPages()
            .map(
              (e) => BottomNavigationBarItem(
                  icon: Icon(e.icon),
                  label: e.name,
                  backgroundColor: themeModel.isDark
                      ? kSecondaryColorDark
                      : kSecondaryColorLight),
            )
            .toList(),
      ),
    );
  }
}