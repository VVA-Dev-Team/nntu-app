import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nntu_app/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Расписание занятий

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  @override
  _LessonsScreenState createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  final RefreshController _refreshController = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.loading);
  int number = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Column(
        children: [
          _ScreenHader(
            title: 'Расписание',
            actions: [
              GestureDetector(
                child: const Icon(
                  Icons.settings,
                  color: kTextColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                child: const Icon(
                  Icons.calendar_month,
                  color: kTextColor,
                  size: 28,
                ),
              ),
            ],
          ),
          _SellectWeekWidget(
            title: number,
            onPressedNext: () {
              setState(() {
                number = number + 1;
              });
            },
            onPressedPrev: () {
              setState(() {
                number = number - 1;
              });
            },
          ),
          Expanded(
            child: _ListLessonsWigdet(
              weekNumber: number,
              refreshController: _refreshController,
              onRefresh: () async {
                await Future.delayed(
                  Duration(milliseconds: 1000),
                );

                if (mounted) setState(() {});
                _refreshController..refreshFailed();
              },
              onLoading: () async {
                await Future.delayed(
                  Duration(milliseconds: 180),
                );

                if (mounted) setState(() {});
                _refreshController.refreshFailed();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ListItebDayWidget extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String title;
  final String description;
  final bool? isfullInfo;
  const _ListItebDayWidget({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.description,
    this.isfullInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 70,
        width: double.infinity,
        margin: EdgeInsets.only(top: 5),
        // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    startTime,
                    style: kTextH4,
                  ),
                  Text(
                    '|',
                    style: kTextH4,
                  ),
                  Text(
                    endTime,
                    style: kTextH4,
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: kTextH3,
                  ),
                  AutoSizeText(
                    description,
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontSize: 14,
                      color: kTextColor.withOpacity(0.5),
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

class _ListLessonsWigdet extends StatelessWidget {
  final int weekNumber;
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;

  _ListLessonsWigdet(
      {required this.weekNumber,
      required this.onLoading,
      required this.onRefresh,
      required this.refreshController});

  @override
  Widget build(BuildContext context) {
    List<String> weekDays = [
      'ПОНЕДЕЛЬНИК',
      'ВТОРНИК',
      'СРЕДА',
      'ЧЕТВЕРГ',
      'ПЯТНИЦА',
      'СУББОТА',
    ];
    final _lessons = [
      ['Русский', 'gbfbdbd'],
      ['', '', '', ''],
      ['', '', '', '', ''],
      [],
      ['', '', ''],
      []
    ];
    return SmartRefresher(
      controller: refreshController,
      footer: const ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        completeDuration: Duration(milliseconds: 500),
      ),
      header: const WaterDropMaterialHeader(
        color: kTextColor,
        backgroundColor: kButtonColor,
      ),
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: ListView.builder(
        itemBuilder: (context, index) => _lessons[index].isEmpty
            ? Container()
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 3),
                      child: Text(
                        weekDays[index],
                        style: GoogleFonts.getFont(
                          'Roboto',
                          fontSize: 14,
                          color: kTextColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _lessons[index].length,
                        separatorBuilder: (context, index) => const Divider(
                          color: kTextColor,
                        ),
                        itemBuilder: (c, i) => _ListItebDayWidget(
                          title: 'Название предмета $weekNumber',
                          description: 'Описание',
                          startTime: '8:00',
                          endTime: '9:30',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        itemCount: 6,
      ),
    );
  }
}

class _SellectWeekWidget extends StatelessWidget {
  final int title;
  final VoidCallback onPressedNext;
  final VoidCallback onPressedPrev;
  const _SellectWeekWidget({
    Key? key,
    required this.title,
    required this.onPressedNext,
    required this.onPressedPrev,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 70,
      decoration: BoxDecoration(
        color: const Color.fromARGB(14, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: onPressedPrev,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(14, 255, 255, 255)),
            ),
            child: const Icon(
              Icons.keyboard_arrow_left_outlined,
              color: kButtonColor,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Center(
              child: Text(
                '$title неделя',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Roboto',
                    fontSize: 21,
                    color: title % 2 == 0 ? Colors.blueAccent : Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: onPressedNext,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(14, 255, 255, 255)),
            ),
            child: const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: kButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScreenHader extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  const _ScreenHader({Key? key, required this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            title,
            style: kTextH1Bold,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: actions ?? [],
          )
        ],
      ),
    );
  }
}
