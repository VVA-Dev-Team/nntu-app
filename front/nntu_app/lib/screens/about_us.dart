import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AdoutUsScreen extends StatelessWidget {
  const AdoutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return ScreenScaffold(
      title: 'О приложении',
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'НГТУ App - не официальное приложение вуза НГТУ Им. Алексеева, разработанной его студентами.',
                  style: Theme.of(context).textTheme.headline3,
                  textDirection: TextDirection.ltr,
                  softWrap: true,
                ),
                const SizedBox(height: 16),
                _LinkButton(
                  themeModel: themeModel,
                  title: 'Группа приложения в ВК',
                  onTap: () async {
                    if (!await launchUrl(
                        Uri.parse('https://vk.com/nntuapp'))) {}
                    ;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const _LinkButton({
    Key? key,
    required this.themeModel,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final ThemeModel themeModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color:
                themeModel.isDark ? kSecondaryColorDark : kSecondaryColorLight,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0, 2),
                  blurRadius: 3,
                  blurStyle: BlurStyle.solid)
            ]),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: themeModel.isDark ? kTextColorDark : kTextColorLight,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.headline3,
              textDirection: TextDirection.ltr,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
