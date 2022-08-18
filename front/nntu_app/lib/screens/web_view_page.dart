import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);

  @override
  WebViewPageState createState() => WebViewPageState(url, title);
}

class WebViewPageState extends State<WebViewPage> {
  final String url;
  final String title;

  WebViewPageState(this.url, this.title);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: WebView(
                  initialUrl: url, javascriptMode: JavascriptMode.unrestricted))
        ],
      ),
    );
  }
}
