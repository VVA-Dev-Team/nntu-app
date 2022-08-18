import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:nntu_app/models/init_model.dart';
import 'package:nntu_app/models/navigation_model.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationModel>(context);
    final initModel = Provider.of<InitModel>(context);
    return Consumer<InitModel>(
      builder: (context, value, child) => initModel.inited
          ? SafeArea(
              child: navigationModel
                  .getPages()[navigationModel.selectedPage]
                  .child,
            )
          : SafeArea(
              child: Scaffold(
                body: Container(
                  color: Colors.white,
                  child: Center(
                    child: Image.asset('assets/icon.png'),
                  ),
                ),
              ),
            ),
    );
  }
}

class _Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 13, color: color);
  }
}
