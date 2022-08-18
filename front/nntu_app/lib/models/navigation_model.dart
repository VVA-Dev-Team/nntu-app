import 'package:flutter/material.dart';
import 'package:nntu_app/screens/additionally_screen.dart';
import 'package:nntu_app/screens/lessons_screen.dart';
import 'package:nntu_app/screens/map_screen.dart';
import 'package:nntu_app/screens/marks_screen.dart';
import 'package:nntu_app/screens/news_screen.dart';

class NavigationModel extends ChangeNotifier {
  NavigationModel() {
    changePage(2);
  }

  int _selectedPage = 2;
  int get selectedPage => _selectedPage;

  final List<PagesClass> _routes = [
    PagesClass(
      child: const NewsScreen(),
      icon: Icons.star_outline,
      name: "События",
    ),
    PagesClass(
      child: MarksScreen(),
      icon: Icons.assessment_outlined,
      name: "Оценки",
    ),
    PagesClass(
      child: MapScreen(),
      icon: Icons.map_outlined,
      name: "Карта",
    ),
    PagesClass(
      child: LessonsScreen(),
      icon: Icons.list_outlined,
      name: "Расписание",
    ),
    PagesClass(
      child: const AdditionallyScreen(),
      icon: Icons.more_horiz_outlined,
      name: "Еще",
    ),
  ];

  List<int> bottomButtons = [0, 1, 2, 3, 4];

  List<PagesClass> _newBottomBar = [];
  List<PagesClass> get newBottomBar => _newBottomBar;

  List<PagesClass> getPages() {
    _newBottomBar = [];
    for (var element in bottomButtons) {
      _newBottomBar.add(_routes[element]);
    }
    return _newBottomBar;
  }

  void changePage(int page) {
    _selectedPage = bottomButtons[page];
    notifyListeners();
  }
}

class PagesClass {
  final Widget child;
  final IconData icon;
  final String name;

  PagesClass({required this.child, required this.icon, required this.name});
}
