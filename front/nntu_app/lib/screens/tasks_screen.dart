import 'package:flutter/material.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';

// Задачи

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: 'Задачи',
      body: Container(
        child: Center(
          child: Text('Задачи'),
        ),
      ),
    );
  }
}
