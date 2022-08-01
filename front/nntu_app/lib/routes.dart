import 'package:flutter/material.dart';
import 'package:nntu_app/screens/additionally_screen.dart';
import 'package:nntu_app/screens/lessons_screen.dart';
import 'package:nntu_app/screens/map_screen.dart';
import 'package:nntu_app/screens/marks_screen.dart';
import 'package:nntu_app/screens/news_screen.dart';
import 'package:nntu_app/screens/settings_screen.dart';
import 'package:nntu_app/screens/tasks_screen.dart';

List<PagesClass> kNavBarRoutes = [
  PagesClass(
    child: const NewsScreen(),
    icon: Icons.star_outline,
    name: "События",
  ),
  PagesClass(
    child: const MarksScreen(),
    icon: Icons.assessment_outlined,
    name: "Оценки",
  ),
  PagesClass(
    child: const MapScreen(),
    icon: Icons.map_outlined,
    name: "Карта",
  ),
  PagesClass(
    child: const LessonsScreen(),
    icon: Icons.list_outlined,
    name: "Расписание",
  ),
  PagesClass(
    child: const AdditionallyScreen(),
    icon: Icons.more_horiz_outlined,
    name: "Еще",
  ),
];

List<PagesClass> kRoutes = [
  PagesClass(
    child: const NewsScreen(),
    icon: Icons.star_outline,
    name: "События",
  ),
  PagesClass(
    child: const MarksScreen(),
    icon: Icons.assessment_outlined,
    name: "Оценки",
  ),
  PagesClass(
    child: const MapScreen(),
    icon: Icons.map_outlined,
    name: "Карта",
  ),
  PagesClass(
    child: const LessonsScreen(),
    icon: Icons.list_outlined,
    name: "Расписание",
  ),
  PagesClass(
    child: const AdditionallyScreen(),
    icon: Icons.more_horiz_outlined,
    name: "Еще",
  ),
  PagesClass(
    child: const SettingsScreen(),
    icon: Icons.settings_outlined,
    name: "Настройки",
  ),
  PagesClass(
    child: const TasksScreen(),
    icon: Icons.playlist_add_check_outlined,
    name: "Задачи",
  ),
];

class PagesClass {
  final Widget child;
  final IconData icon;
  final String name;

  PagesClass({required this.child, required this.icon, required this.name});
}
