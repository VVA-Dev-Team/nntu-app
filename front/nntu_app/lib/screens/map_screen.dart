import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/models/map_model.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

// Карта вуза

class MapScreen extends StatelessWidget {
  TextEditingController roomController = TextEditingController();

  MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final mapModel = Provider.of<MapModel>(context);
    return ScreenScaffold(
      title: 'Навигация',
      body: Container(
        color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
        child: Consumer<MapModel>(
          builder: (context, value, child) => Stack(
            children: [
              PhotoView(
                initialScale: PhotoViewComputedScale.contained * 0.95,
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 1.8,
                backgroundDecoration:
                    const BoxDecoration(color: Colors.transparent),
                imageProvider: AssetImage(mapModel.imageURL),
                enablePanAlways: true,
              ),
              Positioned(
                top: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          margin: const EdgeInsets.only(right: 4, left: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: themeModel.isDark
                                ? kSecondaryColorDark
                                : kSecondaryColorLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: TextField(
                              controller: roomController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"))
                              ],
                              maxLines: 1,
                              autocorrect: false,
                              cursorColor: kButtonColor,
                              style: Theme.of(context).textTheme.headline2,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                disabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                hintText: 'Введите аудиторию..',
                                hintStyle: TextStyle(
                                    color: themeModel.isDark
                                        ? kTextColorDark.withOpacity(0.6)
                                        : kTextColorLight.withOpacity(0.6)),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 16, left: 4),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                          onPressed: () {
                            if (roomController.text != '') {
                              mapModel.setSearchRoomNumber(
                                  int.parse(roomController.text));
                              mapModel.searchImage(true);
                            }
                          },
                          child: Text(
                            'Найти',
                            style: GoogleFonts.getFont(
                              'Roboto',
                              fontSize: 18,
                              color: kTextColorDark,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 70,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      AnimatedToggleSwitch<String>.size(
                        indicatorSize: const Size.fromWidth(70),
                        indicatorColor: kButtonColor,
                        innerColor: themeModel.isDark
                            ? kSecondaryColorDark
                            : kSecondaryColorLight,
                        current: mapModel.typeMenuItem == 0 ? 'Этаж' : 'Корпус',
                        values: const ['Этаж', 'Корпус'],
                        indicatorBorderRadius: BorderRadius.circular(10.0),
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
                                color: const Color.fromARGB(255, 209, 209, 209),
                              ),
                            ),
                          );
                        },
                        onChanged: (i) {
                          mapModel.setTypeMenuItem(i == 'Этаж' ? 0 : 1);
                        },
                      ),
                      const SizedBox(width: 16),
                      mapModel.typeMenuItem == 0
                          ? Expanded(
                              child: AnimatedToggleSwitch<int>.size(
                                indicatorColor: kButtonColor,
                                innerColor: themeModel.isDark
                                    ? kSecondaryColorDark
                                    : kSecondaryColorLight,
                                current: mapModel.floor,
                                values: mapModel.getFloors(mapModel.building),
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
                                onChanged: (i) {
                                  mapModel.chengeFloor(i);
                                },
                              ),
                            )
                          : Expanded(
                              child: AnimatedToggleSwitch<int>.size(
                                indicatorColor: kButtonColor,
                                innerColor: themeModel.isDark
                                    ? kSecondaryColorDark
                                    : kSecondaryColorLight,
                                current: mapModel.building,
                                values: mapModel.buildings,
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
                                onChanged: (i) {
                                  mapModel.chengeBuilding(i);
                                },
                              ),
                            ),
                    ],
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
