import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/models/marks_model.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shimmer/shimmer.dart';

// Оценки

class MarksScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.loading);

  MarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final marksModel = Provider.of<MarksModel>(context);
    return ScreenScaffold(
      title: 'Оценки',
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const _StatScreen()));
          },
          child: Icon(
            Icons.assessment_outlined,
            color: themeModel.isDark ? kTextColorDark : kTextColorLight,
            size: 28,
          ),
        ),
        const SizedBox(width: 16)
      ],
      body: Consumer<MarksModel>(
        builder: (context, value, child) => Container(
          color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
          child: marksModel.initLoading
              ? Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 40, 40, 40),
                  highlightColor: const Color.fromARGB(255, 61, 61, 61),
                  enabled: true,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            width: 170,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            height: 800,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    marksModel.isError
                        ? Center(
                            child: Text(
                              marksModel.errorMessage,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 16),
                              child: AnimatedToggleSwitch<int>.size(
                                indicatorColor: kButtonColor,
                                innerColor: themeModel.isDark
                                    ? kSecondaryColorDark
                                    : kSecondaryColorLight,

                                current: marksModel.selectedSemester,
                                values: List.generate(marksModel.semestersCount,
                                    (index) => index + 1),
                                iconOpacity: 1,
                                borderColor: themeModel.isDark
                                    ? kPrimaryColorDark
                                    : kPrimaryColorLight,
                                borderRadius: BorderRadius.circular(10.0),
                                iconBuilder: (value, size) {
                                  return Center(
                                    child: Text(
                                      value.toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.getFont(
                                        'Roboto',
                                        fontSize: 18,
                                        color: const Color.fromARGB(
                                            255, 209, 209, 209),
                                      ),
                                    ),
                                  );
                                },
                                // indicatorSize: Size.fromWidth(100),
                                onChanged: (i) => marksModel.setSemester(i),
                              ),
                            ),
                          ),
                    const SizedBox(height: 24),
                    marksModel.isError
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '${marksModel.selectedSemester} семестр',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: _ListLessonsWigdet(
                        refreshController: _refreshController,
                        marks: marksModel.marks,
                        selectedSemester: marksModel.selectedSemester,
                        onRefresh: () async {
                          await marksModel.getMarks();
                          _refreshController.refreshFailed();
                        },
                        onLoading: () async {
                          await Future.delayed(
                            const Duration(milliseconds: 180),
                          );
                          _refreshController.refreshFailed();
                        },
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

class _StatScreen extends StatelessWidget {
  const _StatScreen({
    Key? key,
  }) : super(key: key);

  int getAvegage(List list) {
    int average = 0;

    for (var e in list) {
      average += e as int;
    }

    return (average / list.length).round();
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final marksModel = Provider.of<MarksModel>(context);
    return ScreenScaffold(
      disableNavbar: true,
      title: 'Средний балл',
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Общий',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeModel.isDark
                      ? kSecondaryColorDark
                      : kSecondaryColorLight,
                ),
                child: Row(
                  children: [
                    Text(
                      'Средний балл',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const Spacer(),
                    Text(
                      '${marksModel.stat.average}',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'По дисциплинам',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeModel.isDark
                      ? kSecondaryColorDark
                      : kSecondaryColorLight,
                ),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: marksModel.stat.predmets.length,
                  separatorBuilder: (context, index) => Divider(
                    color: themeModel.isDark ? kTextColorDark : kTextColorLight,
                  ),
                  itemBuilder: (context, index) => Container(
                    // margin: EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            marksModel.stat.predmets[index].name,
                            maxLines: 3,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${getAvegage(marksModel.stat.predmets[index].marks)}',
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'По семестрам',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeModel.isDark
                      ? kSecondaryColorDark
                      : kSecondaryColorLight,
                ),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: ((context, index) => Row(
                          children: [
                            Text(
                              '${index + 1} семестр',
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const Spacer(),
                            Text(
                              '${marksModel.stat.term[index]}',
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        )),
                    separatorBuilder: ((context, index) => Divider(
                          color: themeModel.isDark
                              ? kTextColorDark
                              : kTextColorLight,
                        )),
                    itemCount: marksModel.stat.term.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListLessonsWigdet extends StatelessWidget {
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final MarksData marks;
  final int selectedSemester;

  const _ListLessonsWigdet({
    required this.onLoading,
    required this.onRefresh,
    required this.refreshController,
    required this.marks,
    required this.selectedSemester,
  });

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color:
              themeModel.isDark ? kSecondaryColorDark : kSecondaryColorLight),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: SmartRefresher(
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
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          separatorBuilder: ((context, index) => Divider(
                color: themeModel.isDark ? kTextColorDark : kTextColorLight,
              )),
          itemBuilder: ((context, index) => Container(
                color: themeModel.isDark
                    ? kSecondaryColorDark
                    : kSecondaryColorLight,
                padding: const EdgeInsets.only(bottom: 3, top: 5),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => _LessonInfoScreen(
                            marks: marks,
                            selectedSemester: selectedSemester,
                            index: index,
                          ),
                        ));
                  }),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(
                              marks.semesters[selectedSemester - 1].marks[index]
                                  .predmet,
                              // maxLines: 2,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                marks.semesters[selectedSemester - 1]
                                    .marks[index].typeOfAttestation,
                                style: Theme.of(context).textTheme.headline4,
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                marks.semesters[selectedSemester - 1]
                                    .marks[index].session,
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          itemCount: marks.semesters.isEmpty
              ? 0
              : marks.semesters[selectedSemester - 1].marks.length,
        ),
      ),
    );
  }
}

class _LessonInfoScreen extends StatelessWidget {
  const _LessonInfoScreen({
    Key? key,
    required this.marks,
    required this.selectedSemester,
    required this.index,
  }) : super(key: key);

  final int index;
  final MarksData marks;
  final int selectedSemester;

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return ScreenScaffold(
      disableNavbar: true,
      title: '',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            marks.semesters[selectedSemester - 1].marks[index].predmet,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${marks.semesters[selectedSemester - 1].marks[index].typeOfAttestation}: ',
                style: Theme.of(context).textTheme.headline3,
              ),
              marks.semesters[selectedSemester - 1].marks[index]
                          .typeOfAttestation ==
                      'зачет'
                  ? Text(
                      marks
                          .semesters[selectedSemester - 1].marks[index].session,
                      style: GoogleFonts.getFont('Exo 2',
                          fontSize: 18,
                          color: marks.semesters[selectedSemester - 1]
                                      .marks[index].session ==
                                  'зачёт'
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      marks
                          .semesters[selectedSemester - 1].marks[index].session,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '1 кн',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    marks.semesters[selectedSemester - 1].marks[index].kn1.mark,
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontSize: 36,
                      color:
                          themeModel.isDark ? kTextColorDark : kTextColorLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    marks
                        .semesters[selectedSemester - 1].marks[index].kn1.leave,
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontSize: 36,
                      color:
                          themeModel.isDark ? kTextColorDark : kTextColorLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'пропусков',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '2 кн',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    marks.semesters[selectedSemester - 1].marks[index].kn2.mark,
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontSize: 36,
                      color:
                          themeModel.isDark ? kTextColorDark : kTextColorLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    marks
                        .semesters[selectedSemester - 1].marks[index].kn2.leave,
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontSize: 36,
                      color:
                          themeModel.isDark ? kTextColorDark : kTextColorLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'пропусков',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ],
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
    final themeModel = Provider.of<ThemeModel>(context);
    return Container(
      color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: actions ?? [],
          )
        ],
      ),
    );
  }
}
