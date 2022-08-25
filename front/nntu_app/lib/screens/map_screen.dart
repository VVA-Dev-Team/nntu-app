import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/models/map_model.dart';
import 'package:nntu_app/theme/theme_manager.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
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
      title: 'Карта',
      body: Container(
        color: themeModel.isDark ? kPrimaryColorDark : kPrimaryColorLight,
        child: Consumer<MapModel>(
          builder: (context, value, child) => Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(right: 4, left: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: themeModel.isDark
                              ? kSecondaryColorDark
                              : kSecondaryColorLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: roomController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                          ],
                          maxLines: 1,
                          autocorrect: false,
                          cursorColor: kButtonColor,
                          style: Theme.of(context).textTheme.headline2,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            disabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
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
                    Container(
                      margin: const EdgeInsets.only(right: 16, left: 4),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
              const SizedBox(height: 16),
              _MapImageWidget(
                imageURL: mapModel.imageURL,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapImageWidget extends StatefulWidget {
  final imageURL;
  const _MapImageWidget({
    Key? key,
    required this.imageURL,
  }) : super(key: key);

  @override
  State<_MapImageWidget> createState() => _MapImageWidgetState();
}

class _MapImageWidgetState extends State<_MapImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
        lowerBound: 0.0,
        upperBound: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: kButtonColor),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: ExtendedImage.network(
            widget.imageURL,
            fit: BoxFit.contain,
            enableLoadState: true,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (state) {
              return GestureConfig(
                minScale: 0.9,
                animationMinScale: 0.7,
                maxScale: 3.0,
                animationMaxScale: 3.5,
                speed: 1.0,
                inertialSpeed: 100.0,
                initialScale: 1.0,
                inPageView: false,
                initialAlignment: InitialAlignment.center,
              );
            },
            cache: true,
            loadStateChanged: (ExtendedImageState state) {
              switch (state.extendedImageLoadState) {
                case LoadState.loading:
                  _controller.reset();
                  return Container();
                case LoadState.completed:
                  _controller.forward();
                  return FadeTransition(
                    opacity: _controller,
                    child: ExtendedImage.network(
                      widget.imageURL,
                      fit: BoxFit.contain,
                      enableLoadState: true,
                      mode: ExtendedImageMode.gesture,
                      initGestureConfigHandler: (state) {
                        return GestureConfig(
                          minScale: 0.9,
                          animationMinScale: 0.7,
                          maxScale: 3.0,
                          animationMaxScale: 3.5,
                          speed: 1.0,
                          inertialSpeed: 100.0,
                          initialScale: 1.0,
                          inPageView: false,
                          initialAlignment: InitialAlignment.center,
                        );
                      },
                    ),
                  );
                case LoadState.failed:
                  _controller.reset();
                  return GestureDetector(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Lottie.asset('assets/errorAnimation.json',
                            fit: BoxFit.fill),
                        const Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Text(
                            "load image failed, click to reload",
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      state.reLoadImage();
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
