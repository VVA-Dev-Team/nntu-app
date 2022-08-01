import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Оценки

class MarksScreen extends StatefulWidget {
  const MarksScreen({Key? key}) : super(key: key);

  @override
  _MarksScreenState createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  final RefreshController _refreshController = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.loading);
  final _semesters = [1, 2, 3, 4, 5, 6];
  int _selectedSemester = 1;

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
                values: _semesters,
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
          SizedBox(height: 24),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$_selectedSemester семестр',
              style: kTextH4,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: _ListLessonsWigdet(
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
          )
        ],
      ),
    );
  }
}

class _ListLessonsWigdet extends StatelessWidget {
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;

  _ListLessonsWigdet({
    required this.onLoading,
    required this.onRefresh,
    required this.refreshController,
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
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: ((context, index) => Container(
                color: kSecondaryColor,
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AutoSizeText(
                          'Название предмета',
                          maxLines: 2,
                          style: kTextH2Bold,
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'зачет',
                              style: kTextH4,
                            ),
                            Text(
                              'зачет',
                              style: kTextH2Bold,
                            )
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: kTextColor,
                    ),
                  ],
                ),
              )),
          itemCount: 20,
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
