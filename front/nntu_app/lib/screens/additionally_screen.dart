import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/models/marks_model.dart';
import 'package:nntu_app/screens/marks_screen.dart';
import 'package:nntu_app/screens/settings_screen.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Еще

class AdditionallyScreen extends StatefulWidget {
  const AdditionallyScreen({Key? key}) : super(key: key);

  @override
  _AdditionallyScreenState createState() => _AdditionallyScreenState();
}

class _AdditionallyScreenState extends State<AdditionallyScreen> {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // height: 280,
                width: double.infinity,
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
                child: const _LoginWidget(),
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
                          SizedBox(width: 10),
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
                      color:
                          themeModel.isDark ? kTextColorDark : kTextColorLight,
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
                      color:
                          themeModel.isDark ? kTextColorDark : kTextColorLight,
                    ),
                    GestureDetector(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginWidget extends StatefulWidget {
  const _LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<_LoginWidget> {
  String userName = '';
  String userSername = '';
  String userPatronymic = '';
  String userGroup = '';
  String userType = '';
  String userKey = '';

  Future<void> removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    await prefs.remove('userSername');
    await prefs.remove('userPatronymic');
    await prefs.remove('userGroup');
    await prefs.remove('userType');
    await prefs.remove('userKey');
    setState(() {});
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? '';
    userSername = prefs.getString('userSername') ?? '';
    userPatronymic = prefs.getString('userPatronymic') ?? '';
    userGroup = prefs.getString('userGroup') ?? '';
    userType = prefs.getString('userType') ?? '';
    userKey = prefs.getString('userKey') ?? '';
    setState(() {});
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                userSername == '' ? 'Фамилия' : userSername,
                maxLines: 2,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              AutoSizeText(
                userName == '' ? 'Имя' : userName,
                maxLines: 2,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              AutoSizeText(
                userPatronymic == '' ? 'Отчество' : userPatronymic,
                maxLines: 2,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Группа:',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  AutoSizeText(
                    userGroup,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    '№ билета:',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  AutoSizeText(
                    userKey,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Container(
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  removeUserData();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(themeModel.isDark
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
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                          context: context,
                          builder: (BuildContext context) => _EditAlirtDialog())
                      .then((_) => getUserData());
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(themeModel.isDark
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
        ),
        SizedBox(height: 30),
      ],
    );
  }
}

class _EditAlirtDialog extends StatefulWidget {
  _EditAlirtDialog({Key? key}) : super(key: key);

  @override
  State<_EditAlirtDialog> createState() => _EditAlirtDialogState();
}

class _EditAlirtDialogState extends State<_EditAlirtDialog> {
  String userName = '';

  String userSername = '';

  String userPatronymic = '';

  String userGroup = '';

  String userType = 'bak_spec';

  String userKey = '';

  int value = 0;

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? '';
    userSername = prefs.getString('userSername') ?? '';
    userPatronymic = prefs.getString('userPatronymic') ?? '';
    userGroup = prefs.getString('userGroup') ?? '';
    userType = prefs.getString('userType') ?? userType;
    userKey = prefs.getString('userKey') ?? '';
    setState(() {});
  }

  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
    await prefs.setString('userSername', userSername);
    await prefs.setString('userPatronymic', userPatronymic);
    await prefs.setString('userGroup', userGroup);
    await prefs.setString('userType', userType);
    await prefs.setString('userKey', userKey);
    Navigator.pop(context);
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final marksModel = Provider.of<MarksModel>(context, listen: false);
    return AlertDialog(
      backgroundColor:
          themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
      title: Text(
        'Изменение данных',
        style: Theme.of(context).textTheme.subtitle2,
      ),
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InputField(
                title: 'Фамилия',
                fieldText: 'фимилию',
                initValue: userSername,
                onChanged: (text) {
                  userSername = text;
                },
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              _InputField(
                title: 'Имя',
                fieldText: 'имя',
                initValue: userName,
                onChanged: (text) {
                  userName = text;
                },
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              _InputField(
                title: 'Отчество',
                fieldText: 'отчество',
                initValue: userPatronymic,
                onChanged: (text) {
                  userPatronymic = text;
                },
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              Divider(
                  color: themeModel.isDark ? kTextColorDark : kTextColorLight,
                  thickness: 1),
              _InputField(
                title: 'Группа',
                fieldText: 'группу',
                initValue: userGroup,
                onChanged: (text) {
                  userGroup = text;
                },
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              _InputField(
                title: 'Номер студенческого билета',
                fieldText: 'номер',
                initValue: userKey,
                onChanged: (text) {
                  userKey = text;
                },
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              Divider(
                  color: themeModel.isDark ? kTextColorDark : kTextColorLight,
                  thickness: 1),
              Text('Форма обучения',
                  style: Theme.of(context).textTheme.subtitle2),
              DropdownButton(
                  isExpanded: true,
                  value: value,
                  style: Theme.of(context).textTheme.bodyText1,
                  dropdownColor: themeModel.isDark
                      ? kSecondaryColorDark
                      : kSecondaryColorLight,
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Бакалавриат / специалитет',
                          overflow: TextOverflow.ellipsis),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child:
                          Text('Магистратура', overflow: TextOverflow.ellipsis),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Преподаватель / аспирант',
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                  onChanged: (index) {
                    value = index as int;
                    if (index == 0) {
                      userType = 'bak_spec';
                    }
                    if (index == 1) {
                      userType = 'mag';
                    }
                    if (index == 2) {
                      userType = 'teacher';
                    }
                    setState(() {});
                  }),
              Divider(
                  thickness: 1,
                  color: themeModel.isDark ? kTextColorDark : kTextColorLight),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    marksModel.getMarks();
                    saveUserData();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          themeModel.isDark
                              ? kSecondaryColorDark
                              : kSecondaryColorLight)),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.save_outlined,
                        color: Color.fromARGB(255, 75, 243, 33),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Сохранить',
                        style: TextStyle(
                            color: Color.fromARGB(255, 75, 243, 33),
                            fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String title;
  final String initValue;
  final String fieldText;
  final VoidCallback onEditingComplete;
  final ValueChanged onChanged;
  const _InputField(
      {Key? key,
      required this.title,
      required this.onChanged,
      this.initValue = '',
      required this.fieldText,
      required this.onEditingComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.subtitle2),
        TextField(
          controller: TextEditingController(text: initValue),
          style: Theme.of(context).textTheme.headline2,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            border: InputBorder.none,
            hintText: "Введите $fieldText",
            hintStyle: Theme.of(context).textTheme.bodyText1,
            fillColor:
                themeModel.isDark ? kSecondaryColorDark : kSecondaryColorLight,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
