import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/models/additionally_controller.dart';
import 'package:nntu_app/models/marks_model.dart';
import 'package:nntu_app/screens/about_us.dart';
import 'package:nntu_app/screens/settings_screen.dart';
import 'package:nntu_app/screens/tasks_screen.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

// Еще

class AdditionallyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return ScreenScaffold(
      title: '',
      disableAppbar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
        child: Column(
          children: [
            Container(
              // height: 350,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 2),
                      blurRadius: 3,
                      blurStyle: BlurStyle.solid)
                ],
                color: themeModel.isDark
                    ? kSecondaryColorDark
                    : kSecondaryColorLight,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: _LoginWidget(),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: themeModel.isDark
                    ? kSecondaryColorDark
                    : kSecondaryColorLight,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 2),
                      blurRadius: 3,
                      blurStyle: BlurStyle.solid)
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsScreen()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          color: themeModel.isDark
                              ? kTextColorDark
                              : kTextColorLight,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Настройки',
                          style: Theme.of(context).textTheme.headline2,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                    color: themeModel.isDark ? kTextColorDark : kTextColorLight,
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_outlined,
                          color: themeModel.isDark
                              ? kTextColorDark
                              : kTextColorLight,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Поиск преподавателя',
                          style: Theme.of(context).textTheme.headline2,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                    color: themeModel.isDark ? kTextColorDark : kTextColorLight,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TasksScreen()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.playlist_add_check_outlined,
                          color: themeModel.isDark
                              ? kTextColorDark
                              : kTextColorLight,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Задачи',
                          style: Theme.of(context).textTheme.headline2,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                    color: themeModel.isDark ? kTextColorDark : kTextColorLight,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdoutUsScreen()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: themeModel.isDark
                              ? kTextColorDark
                              : kTextColorLight,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'О приложении',
                          style: Theme.of(context).textTheme.headline2,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final additionallyModel = Provider.of<AdditionallyModel>(context);
    return additionallyModel.isLoaded
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Container(
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (val) {
                          additionallyModel.setUserSername(val);
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        enabled: additionallyModel.edited,
                        initialValue: additionallyModel.userSername,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onChanged: (val) {
                          additionallyModel.setUserName(val);
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        enabled: additionallyModel.edited,
                        initialValue: additionallyModel.userName,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onChanged: (val) {
                          additionallyModel.setUserPatronymic(val);
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        enabled: additionallyModel.edited,
                        initialValue: additionallyModel.userPatronymic,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Группа:',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Expanded(
                            child: TextFormField(
                              onChanged: (val) {
                                additionallyModel.setUserGroup(val);
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                border: InputBorder.none,
                              ),
                              enabled: additionallyModel.edited,
                              initialValue: additionallyModel.userGroup,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            '№ билета:',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Expanded(
                            child: TextFormField(
                              onChanged: (val) {
                                additionallyModel.setUserKey(val);
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                border: InputBorder.none,
                              ),
                              enabled: additionallyModel.edited,
                              initialValue: '${additionallyModel.userKey}',
                              maxLines: 2,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              additionallyModel.edited
                  ? ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  titleTextStyle:
                                      Theme.of(context).textTheme.headline3,
                                  title: Text(
                                    'Кем Вы являетесь?',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  content: SizedBox(
                                    height: 240,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 70,
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 8)),
                                              shadowColor:
                                                  MaterialStateProperty.all(
                                                      kButtonColor),
                                            ),
                                            onPressed: () {
                                              additionallyModel
                                                  .setUserType('bak_spec');
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'СТУДЕНТ БАКАЛАВРИАТА/СПЕЦИАЛИТЕТА',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          height: 70,
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 8)),
                                              shadowColor:
                                                  MaterialStateProperty.all(
                                                      kButtonColor),
                                            ),
                                            onPressed: () {
                                              additionallyModel
                                                  .setUserType('mag');
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'СТУДЕНТ МАГИСТРАТУРЫ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          height: 70,
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 8)),
                                              shadowColor:
                                                  MaterialStateProperty.all(
                                                      kButtonColor),
                                            ),
                                            onPressed: () {
                                              additionallyModel
                                                  .setUserType('teacher');
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'ПРЕПОДАВАТЕЛЬ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )).then((value) {
                          if (additionallyModel.userType != '') {
                            additionallyModel.saveUserData();
                            additionallyModel.setEdited(false);
                          }
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              themeModel.isDark
                                  ? kSecondaryColorDark
                                  : kSecondaryColorLight)),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.login,
                            color: Color.fromARGB(255, 7, 141, 190),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Войти',
                            style: TextStyle(
                                color: Color.fromARGB(255, 7, 141, 190),
                                fontSize: 18),
                          )
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            additionallyModel.removeUserData();
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  themeModel.isDark
                                      ? kSecondaryColorDark
                                      : kSecondaryColorLight)),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.close_outlined,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Выйти',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            additionallyModel.setEdited(true);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  themeModel.isDark
                                      ? kSecondaryColorDark
                                      : kSecondaryColorLight)),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.edit_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Изменить',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 30),
            ],
          )
        : Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 40, 40, 40),
            highlightColor: const Color.fromARGB(255, 61, 61, 61),
            enabled: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Container(
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          color: Colors.black,
                          width: double.infinity,
                          height: 30,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          color: Colors.black,
                          width: double.infinity,
                          height: 30,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          color: Colors.black,
                          width: double.infinity,
                          height: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Группа:',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 4, bottom: 4),
                                color: Colors.black,
                                width: double.infinity,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              '№ билета:',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 4, bottom: 4),
                                color: Colors.black,
                                width: double.infinity,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // removeUserData();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              themeModel.isDark
                                  ? kSecondaryColorDark
                                  : kSecondaryColorLight)),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.close_outlined,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Выйти',
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        additionallyModel.setEdited(true);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              themeModel.isDark
                                  ? kSecondaryColorDark
                                  : kSecondaryColorLight)),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.edit_outlined,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Изменить',
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          );
  }
}
