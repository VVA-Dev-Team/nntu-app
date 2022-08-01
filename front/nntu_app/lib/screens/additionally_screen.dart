import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/widgets/screen_hader.dart';

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
              child: Column(
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
                          'Василий',
                          maxLines: 2,
                          style: kTextH1Bold,
                        ),
                        AutoSizeText(
                          'Васильевич',
                          maxLines: 2,
                          style: kTextH1Bold,
                        ),
                        AutoSizeText(
                          'Васильев',
                          maxLines: 2,
                          style: kTextH1Bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
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
                              '21-ИВТ-1',
                              style: kTextH2Bold,
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              '№ билета:',
                              style: kTextH3,
                            ),
                            AutoSizeText(
                              '21-ИВТ-1',
                              style: kTextH2Bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
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
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
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
