import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nntu_app/app.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/models/init_model.dart';
import 'package:nntu_app/models/lessons_model.dart';
import 'package:nntu_app/models/map_model.dart';
import 'package:nntu_app/models/marks_model.dart';
import 'package:nntu_app/models/navigation_model.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => NavigationModel()),
        ChangeNotifierProvider(create: (_) => LessonsModel()),
        ChangeNotifierProvider(create: (_) => MapModel()),
        ChangeNotifierProvider(create: (_) => MarksModel()),
        ChangeNotifierProvider(create: (_) => InitModel()),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'НГТУ',
            theme: themeNotifier.isDark
                ? ThemeData.dark().copyWith(
                    primaryColor: kButtonColor,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: kAppBarBackgroundColorDark,
                      iconTheme: IconThemeData(color: kButtonColor),
                    ),
                    textTheme: TextTheme(
                      headline1: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 24,
                        color: kTextColorDark,
                      ),
                      headline2: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 21,
                        color: kTextColorDark,
                      ),
                      headline3: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 18,
                        color: kTextColorDark,
                      ),
                      headline4: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 14,
                        color: kTextColorDark,
                      ),
                      subtitle1: GoogleFonts.getFont(
                        'Exo 2',
                        fontSize: 24,
                        color: kTextColorDark,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle2: GoogleFonts.getFont(
                        'Exo 2',
                        fontSize: 21,
                        color: kTextColorDark,
                        fontWeight: FontWeight.bold,
                      ),
                      bodyText1: GoogleFonts.getFont(
                        'Exo 2',
                        fontSize: 18,
                        color: kTextColorDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ThemeData.light().copyWith(
                    primaryColor: kButtonColor,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: kAppBarBackgroundColorLight,
                      iconTheme: IconThemeData(color: kButtonColor),
                    ),
                    textTheme: TextTheme(
                      headline1: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 24,
                        color: kTextColorLight,
                      ),
                      headline2: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 21,
                        color: kTextColorLight,
                      ),
                      headline3: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 18,
                        color: kTextColorLight,
                      ),
                      headline4: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 14,
                        color: kTextColorLight,
                      ),
                      subtitle1: GoogleFonts.getFont(
                        'Exo 2',
                        fontSize: 24,
                        color: kTextColorLight,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle2: GoogleFonts.getFont(
                        'Exo 2',
                        fontSize: 21,
                        color: kTextColorLight,
                        fontWeight: FontWeight.bold,
                      ),
                      bodyText1: GoogleFonts.getFont(
                        'Exo 2',
                        fontSize: 18,
                        color: kTextColorLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            home: const App(),
          );
        },
      ),
    );
  }
}
