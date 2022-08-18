import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/models/http_controller.dart';
import 'package:nntu_app/screens/web_view_page.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shimmer/shimmer.dart';

// Новости

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool isLoading = true;
  bool isError = false;

  List _news = [];

  Future<void> _getEvents() async {
    final data = await getDataGetRequest('api/events/', context);
    if (data != 'error') {
      _news = data;
      if (kDebugMode) {
        print(_news);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  final RefreshController _refreshController = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.loading);

  @override
  void initState() {
    _getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return ScreenScaffold(
      title: 'События',
      body: Container(
        color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
        child: Column(
          children: [
            Container(
                child: isError
                    ? Center(
                        child: Lottie.asset('assets/errorAnimation.json',
                            fit: BoxFit.fill),
                      )
                    : Expanded(
                        child: isLoading
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 40, 40, 40),
                                highlightColor:
                                    const Color.fromARGB(255, 61, 61, 61),
                                enabled: true,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: ListView.separated(
                                      itemBuilder: ((context, index) => Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            color: themeModel.isDark
                                                ? kSecondaryColorDark
                                                : kSecondaryColorLight,
                                            child: const SizedBox(
                                              height: 400,
                                              width: double.infinity,
                                            ),
                                          )),
                                      separatorBuilder: ((context, index) =>
                                          const SizedBox(height: 16)),
                                      itemCount: 3),
                                ))
                            : _ListNewsWigdet(
                                onLoading: () {},
                                onRefresh: () async {
                                  await _getEvents();
                                  if (mounted) setState(() {});
                                  _refreshController.refreshFailed();
                                },
                                refreshController: _refreshController,
                                news: _news,
                              ),
                      )),
          ],
        ),
      ),
    );
  }
}

class _ListNewsWigdet extends StatelessWidget {
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final List news;

  _ListNewsWigdet({
    required this.onLoading,
    required this.onRefresh,
    required this.refreshController,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return SmartRefresher(
      controller: refreshController,
      footer: const ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        completeDuration: Duration(milliseconds: 500),
      ),
      header: WaterDropMaterialHeader(
        color: themeModel.isDark ? kTextColorDark : kTextColorLight,
        backgroundColor: kButtonColor,
      ),
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: ((context, index) => const SizedBox(height: 16)),
        itemBuilder: ((context, index) => news[index]["addedBy"] == 'ADMIN'
            ? _AdminNewsCard(
                title: news[index]["title"],
                description: news[index]["description"],
                type: news[index]["type"],
                startTime: news[index]["startTime"],
                fileName: news[index]["fileName"],
                color: news[index]["color"],
                link: news[index]["link"],
              )
            : _SystemNewsCard(
                title: news[index]["title"],
                type: news[index]["type"],
                link: news[index]["link"],
                color: news[index]["color"],
                fileName: news[index]["fileName"],
              )),
        itemCount: news.length,
      ),
    );
  }
}

class _AdminNewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String type;
  final String startTime;
  final String fileName;
  final String color;
  final String link;
  const _AdminNewsCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.type,
      required this.startTime,
      required this.fileName,
      required this.color,
      required this.link})
      : super(key: key);

  void _handleButtonPress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _NewsDetailsScreen(
          title: title,
          description: description,
          type: type,
          startTime: startTime,
          fileName: fileName,
          color: color,
          link: link,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return GestureDetector(
      onTap: () {
        _handleButtonPress(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(0, 3),
                blurRadius: 5,
                blurStyle: BlurStyle.normal)
          ],
        ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: themeModel.isDark ? kSecondaryColorDark : kSecondaryColorLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color.toColor(),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(startTime,
                            style: Theme.of(context).textTheme.headline4),
                        const Spacer(),
                        Text(type,
                            style: Theme.of(context).textTheme.headline4),
                      ],
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: ExtendedImage.network(
                    '${kDebugMode ? debugHostUrl : releaseHostUrl}static/events/$fileName',
                    fit: BoxFit.cover,
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

class _SystemNewsCard extends StatelessWidget {
  final String title;
  final String type;
  final String link;
  final String color;
  final String fileName;
  const _SystemNewsCard(
      {Key? key,
      required this.title,
      required this.type,
      required this.link,
      required this.color,
      required this.fileName})
      : super(key: key);

  void _handleURLButtonPress(BuildContext context, String url, String title) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return GestureDetector(
      onTap: () {
        _handleURLButtonPress(context, link, title);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(0, 3),
                blurRadius: 5,
                blurStyle: BlurStyle.normal)
          ],
        ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: themeModel.isDark ? kSecondaryColorDark : kSecondaryColorLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color.toColor(),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(type, style: Theme.of(context).textTheme.headline4),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: ExtendedImage.network(
                    fileName,
                    fit: BoxFit.cover,
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

class _NewsDetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final String type;
  final String startTime;
  final String fileName;
  final String color;
  final String link;
  const _NewsDetailsScreen(
      {Key? key,
      required this.title,
      required this.description,
      required this.type,
      required this.startTime,
      required this.fileName,
      required this.color,
      required this.link})
      : super(key: key);

  @override
  State<_NewsDetailsScreen> createState() => __NewsDetailsScreenState();
}

class __NewsDetailsScreenState extends State<_NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color.toColor(),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      body: Container(
        color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: ExtendedImage.network(
                      '${kDebugMode ? debugHostUrl : releaseHostUrl}static/events/${widget.fileName}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Divider(
                  height: 16,
                  color: themeModel.isDark ? kTextColorDark : kTextColorLight,
                ),
                Row(
                  children: [
                    Text(
                      widget.startTime,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const Spacer(),
                    Text(
                      widget.type,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: themeModel.isDark ? kTextColorDark : kTextColorLight,
                ),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
