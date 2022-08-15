import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/widgets/screen_hader.dart';
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
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: kPrimaryColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ScreenHader(title: 'Ещё'),
            Container(
              // height: 280,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: _LoginWidget(),
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.settings_outlined,
                          color: kTextColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Настройки',
                          style: kTextH2,
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    color: kTextColor,
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_outlined,
                          color: kTextColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Поиск преподавателя',
                          style: kTextH2,
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    color: kTextColor,
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.playlist_add_check_outlined,
                          color: kTextColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Задачи',
                          style: kTextH2,
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
    prefs.remove('userName');
    prefs.remove('userSername');
    prefs.remove('userPatronymic');
    prefs.remove('userGroup');
    prefs.remove('userType');
    prefs.remove('userKey');
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
                userName == '' ? 'Имя' : userName,
                maxLines: 2,
                style: kTextH1Bold,
              ),
              AutoSizeText(
                userSername == '' ? 'Фамилия' : userSername,
                maxLines: 2,
                style: kTextH1Bold,
              ),
              AutoSizeText(
                userPatronymic == '' ? 'Отчество' : userPatronymic,
                maxLines: 2,
                style: kTextH1Bold,
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
                    style: kTextH3,
                  ),
                  AutoSizeText(
                    userGroup,
                    style: kTextH2Bold,
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
                    style: kTextH3,
                  ),
                  AutoSizeText(
                    userKey,
                    style: kTextH2Bold,
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
                    backgroundColor:
                        MaterialStateProperty.all(kSecondaryColor)),
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
                    backgroundColor:
                        MaterialStateProperty.all(kSecondaryColor)),
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

  String userType = '';

  String userKey = '';

  int value = 0;

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

  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
    prefs.setString('userSername', userSername);
    prefs.setString('userPatronymic', userPatronymic);
    prefs.setString('userGroup', userGroup);
    prefs.setString('userType', userType);
    prefs.setString('userKey', userKey);
    Navigator.pop(context);
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kPrimaryColor,
      title: Text(
        'Изменение данных',
        style: kTextH2Bold,
      ),
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InputField(
                  title: 'Имя',
                  fieldText: 'имя',
                  initValue: userName,
                  onChanged: (text) {
                    setState(() {
                      userName = text;
                    });
                  }),
              _InputField(
                  title: 'Фамилия',
                  fieldText: 'фимилию',
                  initValue: userSername,
                  onChanged: (text) {
                    setState(() {
                      userSername = text;
                    });
                  }),
              _InputField(
                  title: 'Отчество',
                  fieldText: 'отчество',
                  initValue: userPatronymic,
                  onChanged: (text) {
                    setState(() {
                      userPatronymic = text;
                    });
                  }),
              const Divider(color: kTextColor, thickness: 1),
              _InputField(
                  title: 'Группа',
                  fieldText: 'группу',
                  initValue: userGroup,
                  onChanged: (text) {
                    setState(() {
                      userGroup = text;
                    });
                  }),
              _InputField(
                  title: 'Номер студенческого билета',
                  fieldText: 'номер',
                  initValue: userKey,
                  onChanged: (text) {
                    setState(() {
                      userKey = text;
                    });
                  }),
              const Divider(color: kTextColor, thickness: 1),
              Text('Форма обучения', style: kTextH2Bold),
              DropdownButton(
                  isExpanded: true,
                  value: value,
                  style: kTextH3Bold,
                  dropdownColor: kSecondaryColor,
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
              const Divider(thickness: 1, color: kTextColor),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    saveUserData();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kSecondaryColor)),
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
  final ValueChanged onChanged;
  const _InputField(
      {Key? key,
      required this.title,
      required this.onChanged,
      this.initValue = '',
      required this.fieldText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: kTextH2Bold),
        TextField(
          style: kTextH2,
          controller: TextEditingController(text: initValue),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            border: InputBorder.none,
            hintText: "Введите $fieldText",
            hintStyle: kTextH3Bold,
            fillColor: kSecondaryColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onSubmitted: onChanged,
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
