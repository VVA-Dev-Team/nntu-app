import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/routes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _sellectedPage = 4;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: BottomNavyBar(
        //   showElevation: false,
        //   selectedIndex: _sellectedPage,
        //   onItemSelected: (index) {
        //     setState(() {
        //       _sellectedPage = index;
        //     });
        //   },
        //   backgroundColor: kSecondaryColor,
        //   items: kNavBarRoutes
        //       .map(
        //         (e) => BottomNavyBarItem(
        //           inactiveColor: kTextColor,
        //           activeColor: kTextColor,
        //           icon: Icon(e.icon),
        //           title: Center(
        //             child: Text(e.name),
        //           ),
        //         ),
        //       )
        //       .toList(),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kSecondaryColor,
          currentIndex: _sellectedPage,
          selectedItemColor: kButtonColor,
          unselectedItemColor: kTextColor,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          onTap: (index) {
            setState(() {
              _sellectedPage = index;
            });
          },
          items: kNavBarRoutes
              .map(
                (e) => BottomNavigationBarItem(
                    icon: Icon(e.icon),
                    label: e.name,
                    backgroundColor: kSecondaryColor),
              )
              .toList(),
        ),
        body: kNavBarRoutes[_sellectedPage].child,
      ),
    );
  }
}

class _Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 13, color: color);
  }
}
