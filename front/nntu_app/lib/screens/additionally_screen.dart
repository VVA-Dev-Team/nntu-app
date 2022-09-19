import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/models/additionally_model.dart';
import 'package:nntu_app/screens/about_us.dart';
import 'package:nntu_app/screens/settings_screen.dart';
import 'package:nntu_app/screens/tasks_screen.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// Еще

class AdditionallyScreen extends StatelessWidget {
  const AdditionallyScreen({Key? key}) : super(key: key);

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
              decoration: BoxDecoration(
                color: themeModel.isDark
                    ? kSecondaryColorDark
                    : kSecondaryColorLight,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
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
                        const SizedBox(width: 10),
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
                        const SizedBox(width: 10),
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
              const SizedBox(height: 24),
              SizedBox(
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(
                            text: additionallyModel.userSername),
                        onChanged: (val) {
                          additionallyModel.setUserSername(val);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintText: 'Фамилия',
                          hintStyle: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 24,
                            color: themeModel.isDark
                                ? kTextColorDark.withOpacity(0.5)
                                : kTextColorLight.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        enabled: additionallyModel.edited,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(
                            text: additionallyModel.userName),
                        onChanged: (val) {
                          additionallyModel.setUserName(val);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintText: 'Имя',
                          hintStyle: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 24,
                            color: themeModel.isDark
                                ? kTextColorDark.withOpacity(0.5)
                                : kTextColorLight.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        enabled: additionallyModel.edited,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(
                            text: additionallyModel.userPatronymic),
                        onChanged: (val) {
                          additionallyModel.setUserPatronymic(val);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintText: 'Отчество',
                          hintStyle: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 24,
                            color: themeModel.isDark
                                ? kTextColorDark.withOpacity(0.5)
                                : kTextColorLight.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        enabled: additionallyModel.edited,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
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
                              controller: TextEditingController(
                                  text: additionallyModel.userGroup),
                              onChanged: (val) {
                                additionallyModel.setUserGroup(val);
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(0),
                                border: InputBorder.none,
                                hintText: 'Группа',
                                hintStyle: GoogleFonts.getFont(
                                  'Roboto',
                                  fontSize: 24,
                                  color: themeModel.isDark
                                      ? kTextColorDark.withOpacity(0.5)
                                      : kTextColorLight.withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              enabled: additionallyModel.edited,
                              maxLines: 1,
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
                              controller: TextEditingController(
                                  text: additionallyModel.userKey),
                              onChanged: (val) {
                                additionallyModel.setUserKey(val);
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(0),
                                border: InputBorder.none,
                                hintText: '№ билета',
                                hintStyle: GoogleFonts.getFont(
                                  'Roboto',
                                  fontSize: 24,
                                  color: themeModel.isDark
                                      ? kTextColorDark.withOpacity(0.5)
                                      : kTextColorLight.withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              enabled: additionallyModel.edited,
                              maxLines: 1,
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
                        if (additionallyModel.userName != '' &&
                            additionallyModel.userSername != '' &&
                            additionallyModel.userGroup != '' &&
                            additionallyModel.userKey != '') {
                          showDialog(
                              barrierDismissible: false,
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
                                      height: 270,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 80,
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
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Roboto',
                                                  fontSize: 18,
                                                  color: kTextColorDark,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            height: 80,
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
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Roboto',
                                                  fontSize: 18,
                                                  color: kTextColorDark,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            height: 80,
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
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Roboto',
                                                  fontSize: 18,
                                                  color: kTextColorDark,
                                                ),
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
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Text(
                                      'Упс, кажется заполнены не все поля!',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ));
                        }
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
              const SizedBox(height: 30),
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
                SizedBox(
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
                SizedBox(
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
                const SizedBox(height: 30),
              ],
            ),
          );
  }
}
