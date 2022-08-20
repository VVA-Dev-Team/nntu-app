import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/models/tasks_model.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

// Задачи

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final RefreshController refreshController = RefreshController(
      initialRefresh: true, initialLoadStatus: LoadStatus.loading);
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final tasksModel = Provider.of<TasksModel>(context);
    return ScreenScaffold(
      title: 'Задачи',
      disableNavbar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const _TasksEditorScreen()));
        },
        backgroundColor: kButtonColor,
        child: const Icon(
          Icons.add_outlined,
          color: kTextColorDark,
        ),
      ),
      body: Consumer<TasksModel>(builder: (context, value, state) {
        return Container(
          color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SmartRefresher(
            controller: refreshController,
            footer: const ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              completeDuration: Duration(milliseconds: 500),
            ),
            header: const WaterDropMaterialHeader(
              color: kTextColorDark,
              backgroundColor: kButtonColor,
            ),
            onRefresh: () async {
              await tasksModel.getTasks();
              refreshController.refreshFailed();
            },
            child: ListView.separated(
                itemBuilder: ((context, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      child: Slidable(
                        key: ValueKey(index),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          dragDismissible: false,
                          children: [
                            SlidableAction(
                              borderRadius: BorderRadius.circular(10),
                              onPressed: (context) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'Задача удалится для всех',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    content: Text(
                                      'Вы уверены, что хотите её удалить?',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    actionsAlignment:
                                        MainAxisAlignment.spaceAround,
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'ОТМЕНА',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          tasksModel.deleteTask(
                                              tasksModel.tasks[index].id);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'УДАЛИТЬ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Удалить',
                            ),
                          ],
                        ),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          dragDismissible: false,
                          children: [
                            SlidableAction(
                              borderRadius: BorderRadius.circular(10),
                              onPressed: (context) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            _TasksEditorScreen(
                                              index: index,
                                              isEditor: true,
                                            )));
                              },
                              backgroundColor: Color(0xFF0392CF),
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Изменить',
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => _TaskInfoScreen(
                                          taskInfo: tasksModel.tasks[index],
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: themeModel.isDark
                                  ? kSecondaryColorDark
                                  : kSecondaryColorLight,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(0, 1),
                                    blurRadius: 3,
                                    blurStyle: BlurStyle.solid),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(tasksModel.tasks[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                    Text(tasksModel.tasks[index].lessonName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                    Text(tasksModel.tasks[index].stopDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                  ],
                                ),
                                const Spacer(),
                                Checkbox(
                                  value: tasksModel.tasks[index].status,
                                  onChanged: (i) {
                                    tasksModel.setTaskStatus(index, i ?? false);
                                  },
                                  checkColor: kTextColorDark,
                                  fillColor: MaterialStateProperty.all(
                                      tasksModel.tasks[index].priority ==
                                              'Очень срочное'
                                          ? Colors.red
                                          : tasksModel.tasks[index].priority ==
                                                  'Срочное'
                                              ? Colors.yellow
                                              : kButtonColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                separatorBuilder: ((context, index) =>
                    const SizedBox(height: 8)),
                itemCount: tasksModel.tasks.length),
          ),
        );
      }),
    );
  }
}

class _TaskInfoScreen extends StatelessWidget {
  final Task taskInfo;
  const _TaskInfoScreen({
    Key? key,
    required this.taskInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return ScreenScaffold(
      title: 'Задача',
      disableNavbar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: themeModel.isDark
                        ? kSecondaryColorDark
                        : kSecondaryColorLight,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          blurStyle: BlurStyle.solid),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Задача:',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const Spacer(),
                          Text(
                            taskInfo.title,
                            style: Theme.of(context).textTheme.subtitle2,
                            softWrap: true,
                            maxLines: null,
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Предмет:',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const Spacer(),
                          Text(
                            taskInfo.lessonName,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Приоритет:',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const Spacer(),
                          Text(
                            taskInfo.priority,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Выполнить до:',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const Spacer(),
                          Text(
                            taskInfo.stopDate,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Добавлил:',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const Spacer(),
                          Text(
                            taskInfo.addedByStudent,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: themeModel.isDark
                        ? kSecondaryColorDark
                        : kSecondaryColorLight,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          blurStyle: BlurStyle.solid),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Описание:',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        taskInfo.description,
                        style: Theme.of(context).textTheme.headline3,
                        softWrap: true,
                        maxLines: null,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TasksEditorScreen extends StatelessWidget {
  final bool isEditor;
  final int index;
  const _TasksEditorScreen({Key? key, this.isEditor = false, this.index = -1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final tasksModel = Provider.of<TasksModel>(context, listen: false);
    if (isEditor) {
      tasksModel.setdefPriority(tasksModel.tasks[index].priority);
      tasksModel.setdefStopDate(tasksModel.tasks[index].stopDate);
    }
    return ScreenScaffold(
        disableNavbar: true,
        title: isEditor ? 'Изменение задачи' : 'Добавление задачи',
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (isEditor) {
              await tasksModel.editTask(tasksModel.tasks[index].id);
            } else {
              await tasksModel.addTask();
            }
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.save,
            color: kTextColorDark,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: themeModel.isDark
                          ? kSecondaryColorDark
                          : kSecondaryColorLight,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            blurStyle: BlurStyle.solid),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InputFormWidget(
                        title: 'Название',
                        inFormTitle: 'название',
                        isEditor: isEditor,
                        index: index,
                        initialValue:
                            isEditor ? tasksModel.tasks[index].title : null,
                        onChanged: (val) {
                          tasksModel.setNewTitle(val);
                        },
                      ),
                      const SizedBox(height: 8),
                      _InputFormWidget(
                        title: 'Описание',
                        inFormTitle: 'описание',
                        isEditor: isEditor,
                        index: index,
                        initialValue: isEditor
                            ? tasksModel.tasks[index].description
                            : null,
                        onChanged: (val) {
                          tasksModel.setNewDescription(val);
                        },
                      ),
                      const SizedBox(height: 8),
                      _InputFormWidget(
                        title: 'Предмет',
                        inFormTitle: 'предмет',
                        isEditor: isEditor,
                        index: index,
                        initialValue: isEditor
                            ? tasksModel.tasks[index].lessonName
                            : null,
                        onChanged: (val) {
                          tasksModel.setNewLessonName(val);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: themeModel.isDark
                          ? kSecondaryColorDark
                          : kSecondaryColorLight,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            blurStyle: BlurStyle.solid),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ChangePriorityWidget(
                        isEditor: isEditor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _StopDatePickerWidget(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ));
  }
}

class _StopDatePickerWidget extends StatelessWidget {
  const _StopDatePickerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final tasksModel = Provider.of<TasksModel>(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: themeModel.isDark ? kSecondaryColorDark : kSecondaryColorLight,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(0, 1),
                blurRadius: 3,
                blurStyle: BlurStyle.solid),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Время окончания',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                tasksModel.newStopDate,
                style: Theme.of(context).textTheme.headline3,
              )
            ],
          ),
          const Spacer(),
          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kButtonColor),
              ),
              onPressed: () {
                tasksModel.setNewStopDate(context);
              },
              child: Text(
                'Выбрать',
                style: Theme.of(context).textTheme.headline3,
              )),
        ],
      ),
    );
  }
}

class _InputFormWidget extends StatelessWidget {
  final String title;
  final Function(String) onChanged;
  final String? initialValue;
  final String inFormTitle;
  const _InputFormWidget({
    Key? key,
    required this.isEditor,
    required this.index,
    required this.title,
    required this.onChanged,
    this.initialValue,
    required this.inFormTitle,
  }) : super(key: key);

  final bool isEditor;
  final int index;

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
        TextFormField(
          maxLines: null,
          onChanged: onChanged,
          initialValue: initialValue,
          style: Theme.of(context).textTheme.headline2,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            border: InputBorder.none,
            hintText: "Введите $inFormTitle",
            hintStyle: Theme.of(context).textTheme.headline3,
            fillColor:
                themeModel.isDark ? kSecondaryColorDark : kSecondaryColorLight,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        )
      ],
    );
  }
}

class _ChangePriorityWidget extends StatelessWidget {
  final bool isEditor;
  const _ChangePriorityWidget({Key? key, required this.isEditor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final tasksModel = Provider.of<TasksModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Приоритет',
          style: Theme.of(context).textTheme.headline2,
        ),
        Align(
          alignment: Alignment.center,
          child: Consumer<TasksModel>(builder: (context, value, state) {
            return AnimatedToggleSwitch<String>.size(
              indicatorSize: const Size(100, 65),
              height: 70,
              indicatorColor: kButtonColor,
              innerColor: themeModel.isDark
                  ? kSecondaryColorDark
                  : kSecondaryColorLight,
              current: tasksModel.newPriority,
              values: const ['Не срочное', 'Срочное', 'Очень срочное'],
              iconOpacity: 0.2,
              borderColor:
                  themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
              borderRadius: BorderRadius.circular(20.0),
              iconBuilder: (value, size) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Center(
                    child: Text(
                      value.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                );
              },
              onChanged: (i) {
                tasksModel.setNewPriority(i);
              },
            );
          }),
        ),
      ],
    );
  }
}
