import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/controllers/http_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Оценки

class MarksScreen extends StatefulWidget {
  const MarksScreen({Key? key}) : super(key: key);

  @override
  _MarksScreenState createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  bool _isLoading = true;
  bool _isError = false;

  final RefreshController _refreshController = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.loading);
  int _semestersCount = 1;
  int _selectedSemester = 1;
  List _marks = [];

  dynamic allData;

  Future<void> _getMarks() async {
    if (kDebugMode) {
      print('get marks');
    }
    final data = await getDataGetRequest(
        'api/marks?last_name=Вершинин&first_name=Владимир&otc=Андреевич&n_zach=21-02272&learn_type=bak_spec',
        context);
    if (data != 'error') {
      if (kDebugMode) {
        print(data);
      }

      _semestersCount = data['marks'].length;
      _marks = data['marks'];
      allData = data;
    } else {
      _isError = true;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getMarks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ScreenHader(
            title: 'Оценки',
            actions: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _AlertStatWidget(allData: allData);
                      });
                },
                child: const Icon(
                  Icons.assessment_outlined,
                  color: kTextColor,
                  size: 28,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: AnimatedToggleSwitch<int>.size(
                innerColor: kSecondaryColor,
                current: _selectedSemester,
                values: List.generate(_semestersCount, (index) => index + 1),
                iconOpacity: 0.2,
                borderColor: kPrimaryColor,
                borderRadius: BorderRadius.circular(20.0),
                iconBuilder: (value, size) {
                  return Center(
                    child: Text(
                      value.toString(),
                      textAlign: TextAlign.center,
                      style: kTextH2,
                    ),
                  );
                },
                // indicatorSize: Size.fromWidth(100),
                onChanged: (i) => setState(() => _selectedSemester = i),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$_selectedSemester семестр',
              style: kTextH4,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _isLoading
                ? Container(
                    color: kPrimaryColor,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _isError
                    ? Center(
                        child: Text(
                          'Ошибка соединения с сервером',
                          textAlign: TextAlign.center,
                          style: kTextH2Bold,
                        ),
                      )
                    : _ListLessonsWigdet(
                        refreshController: _refreshController,
                        marks: _marks,
                        selectedSemester: _selectedSemester,
                        onRefresh: () async {
                          await _getMarks();
                          if (mounted) setState(() {});
                          _refreshController.refreshFailed();
                        },
                        onLoading: () async {
                          await Future.delayed(
                            Duration(milliseconds: 180),
                          );

                          if (kDebugMode) {
                            print('OnLoading');
                          }

                          if (mounted) setState(() {});
                          _refreshController.refreshFailed();
                        },
                      ),
          )
        ],
      ),
    );
  }
}

class _AlertStatWidget extends StatelessWidget {
  final allData;
  const _AlertStatWidget({
    Key? key,
    required this.allData,
  }) : super(key: key);

  int getAvegage(List list) {
    int average = 0;

    for (var e in list) {
      average += e as int;
    }

    return (average / list.length).round();
  }

  List<Widget> getList(data) {
    List<Widget> list = [];
    data.forEach((final String key, final value) {
      list.add(
        const Divider(
          color: kTextColor,
        ),
      );
      list.add(
        Container(
          // margin: EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  key,
                  maxLines: 3,
                  style: kTextH3Bold,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${getAvegage(value)}',
                  textAlign: TextAlign.right,
                  style: kTextH3Bold,
                ),
              ),
            ],
          ),
        ),
      );
    });
    list.removeAt(0);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kPrimaryColor,
      title: Column(
        children: [
          Text(
            'Средний балл',
            style: kTextH2Bold,
          ),
          const Divider(
            color: kTextColor,
          ),
        ],
      ),
      content: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Общий',
                style: kTextH4,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kSecondaryColor,
                ),
                child: Row(
                  children: [
                    Text(
                      'Средний балл',
                      maxLines: 2,
                      style: kTextH3Bold,
                    ),
                    const Spacer(),
                    Text(
                      allData['stat']['average'],
                      textAlign: TextAlign.right,
                      style: kTextH3Bold,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'По дисциплинам',
                style: kTextH4,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kSecondaryColor,
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: getList(allData['stat']['predmets']),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'По семестрам',
                style: kTextH4,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kSecondaryColor,
                ),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: ((context, index) => Row(
                          children: [
                            Text(
                              '${index + 1} семестр',
                              maxLines: 2,
                              style: kTextH3Bold,
                            ),
                            const Spacer(),
                            Text(
                              '${allData['stat']['term'][index]}',
                              textAlign: TextAlign.right,
                              style: kTextH3Bold,
                            ),
                          ],
                        )),
                    separatorBuilder: ((context, index) => const Divider(
                          color: kTextColor,
                        )),
                    itemCount: allData['stat']['term'].length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlertElementWidget extends StatelessWidget {
  final List<Widget> items;
  final String title;
  const _AlertElementWidget({
    Key? key,
    required this.items,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: kTextH4,
          ),
          Row(
            children: items,
          ),
        ],
      ),
    );
  }
}

class _ListLessonsWigdet extends StatelessWidget {
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final List marks;
  final int selectedSemester;

  _ListLessonsWigdet({
    required this.onLoading,
    required this.onRefresh,
    required this.refreshController,
    required this.marks,
    required this.selectedSemester,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: kSecondaryColor),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: SmartRefresher(
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
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          separatorBuilder: ((context, index) => const Divider(
                color: kTextColor,
              )),
          itemBuilder: ((context, index) => Container(
                color: kSecondaryColor,
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: GestureDetector(
                  onTap: (() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: kPrimaryColor,
                            title: Text(
                              marks[selectedSemester - 1][index]['predmet'],
                              style: kTextH2Bold,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '1 кн: ${marks[selectedSemester - 1][index]['kn2']['mark'] == -1 ? '?' : marks[selectedSemester - 1][index]['kn2']['mark']}',
                                      style: kTextH3,
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${marks[selectedSemester - 1][index]['kn1']['leave']} пропущено',
                                      style: kTextH3,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      '2 кн: ${marks[selectedSemester - 1][index]['kn2']['mark'] == -1 ? '?' : marks[selectedSemester - 1][index]['kn2']['mark']}',
                                      style: kTextH3,
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${marks[selectedSemester - 1][index]['kn2']['leave']} пропущено',
                                      style: kTextH3,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      '${marks[selectedSemester - 1][index]['typeOfAttestation']}: ',
                                      style: kTextH3,
                                    ),
                                    marks[selectedSemester - 1][index]
                                                ['typeOfAttestation'] ==
                                            'зачет'
                                        ? Text(
                                            '${marks[selectedSemester - 1][index]['session']}',
                                            style: GoogleFonts.getFont('Exo 2',
                                                fontSize: 18,
                                                color:
                                                    marks[selectedSemester - 1]
                                                                    [index]
                                                                ['session'] ==
                                                            'зачёт'
                                                        ? Colors.greenAccent
                                                        : Colors.redAccent,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            '${marks[selectedSemester - 1][index]['session']}',
                                            style: kTextH3Bold,
                                          )
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  }),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text(
                            marks[selectedSemester - 1][index]['predmet'],
                            // maxLines: 2,
                            style: kTextH2Bold,
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
                              '${marks[selectedSemester - 1][index]['typeOfAttestation']}',
                              style: kTextH4,
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              '${marks[selectedSemester - 1][index]['session']}',
                              style: kTextH2Bold,
                              textAlign: TextAlign.right,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          itemCount: marks[selectedSemester - 1].length,
        ),
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
