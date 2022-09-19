import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/models/lessons_model.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

// Расписание занятий

class LessonsScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.loading);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final schedule = Provider.of<LessonsModel>(context);
    return ScreenScaffold(
      title: 'Расписание',
      actions: [
        GestureDetector(
          onTap: () async {
            await schedule.selectDate(context);
          },
          child: Icon(
            Icons.calendar_month,
            color: themeModel.isDark ? kTextColorDark : kTextColorLight,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
      ],
      body: Container(
        color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
        child: Column(
          children: [
            Expanded(
              child: Consumer<LessonsModel>(
                builder: (context, a, child) => _ListLessonsWigdet(
                  schedules: schedule.schedules,
                  refreshController: _refreshController,
                  onRefresh: () async {
                    await schedule.loadSchedule();
                    _refreshController.refreshFailed();
                  },
                  onLoading: () async {
                    await Future.delayed(
                      const Duration(milliseconds: 180),
                    );
                    _refreshController.refreshFailed();
                  },
                ),
              ),
            ),
          ],
        ),
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
    final themeModel = Provider.of<ThemeModel>(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 70,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 5),
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
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    '|',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    endTime,
                    style: Theme.of(context).textTheme.headline4,
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
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  AutoSizeText(
                    description,
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontSize: 14,
                      color:
                          (themeModel.isDark ? kTextColorDark : kTextColorLight)
                              .withOpacity(0.5),
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
  final List<List<Schedule>> schedules;
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;

  _ListLessonsWigdet(
      {required this.schedules,
      required this.onLoading,
      required this.onRefresh,
      required this.refreshController});

  @override
  Widget build(BuildContext context) {
    print(schedules);
    final themeModel = Provider.of<ThemeModel>(context);
    final schedule = Provider.of<LessonsModel>(context);
    List<String> weekDays = [
      'ПОНЕДЕЛЬНИК',
      'ВТОРНИК',
      'СРЕДА',
      'ЧЕТВЕРГ',
      'ПЯТНИЦА',
      'СУББОТА',
      'Воскресенье',
    ];
    return SmartRefresher(
      controller: refreshController,
      footer: const ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        completeDuration: Duration(milliseconds: 500),
      ),
      header: WaterDropMaterialHeader(
        color: themeModel.isDark ? kTextColorDark : kTextColorLight,
        backgroundColor:
            themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
      ),
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: ListView.builder(
        itemBuilder: (context, index) => index == 0
            ? _SellectWeekWidget(
                title: schedule.weekNumber,
                onPressedNext: () {
                  schedule.incrementCount();
                },
                onPressedPrev: () {
                  schedule.decrementCount();
                },
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: schedules[index - 1].isEmpty
                    ? Container()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 3),
                            child: Text(
                              weekDays[index - 1],
                              style: GoogleFonts.getFont(
                                'Roboto',
                                fontSize: 14,
                                color: (themeModel.isDark
                                        ? kTextColorDark
                                        : kTextColorLight)
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: themeModel.isDark
                                  ? kSecondaryColorDark
                                  : kSecondaryColorLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: schedules[index - 1].length,
                              separatorBuilder: (context, index) => Divider(
                                color: themeModel.isDark
                                    ? kTextColorDark
                                    : kTextColorLight,
                              ),
                              itemBuilder: (c, i) => _ListItebDayWidget(
                                title: schedules[index - 1][i].name,
                                description:
                                    '${schedules[index - 1][i].type}, ${schedules[index - 1][i].room}',
                                startTime:
                                    '${schedules[index - 1][i].startTime ~/ 60}:${schedules[index - 1][i].startTime % 60}',
                                endTime:
                                    '${schedules[index - 1][i].stopTime ~/ 60}:${schedules[index - 1][i].stopTime.remainder(60) < 10 ? 0 : ''}${schedules[index - 1][i].stopTime.remainder(60)}',
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
        itemCount: schedules.length + 1,
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
    final themeModel = Provider.of<ThemeModel>(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 70,
      decoration: BoxDecoration(
        color: themeModel.isDark ? kSecondaryColorDark : kSecondaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: onPressedPrev,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight),
            ),
            child: const Icon(
              Icons.keyboard_arrow_left_outlined,
              color: kButtonColor,
            ),
          ),
          const SizedBox(width: 10),
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
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onPressedNext,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight),
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
