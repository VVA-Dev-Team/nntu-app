import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 1),
                        blurRadius: 3,
                        blurStyle: BlurStyle.solid)
                  ],
                  color: themeModel.isDark
                      ? kSecondaryColorDark
                      : kSecondaryColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
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
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          hintText: 'Введите аудиторию..',
                          hintStyle: TextStyle(
                              color: themeModel.isDark
                                  ? kTextColorDark
                                  : kTextColorLight),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 32),
                    ElevatedButton(
                      onPressed: () {
                        if (roomController.text != '') {
                          mapModel.setSearchRoomNumber(
                              int.parse(roomController.text));
                          mapModel.searchImage(true);
                        }
                      },
                      child: Text(
                        'Найти',
                        style: Theme.of(context).textTheme.headline3,
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
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            blurStyle: BlurStyle.solid)
                      ],
                      indicatorSize: Size.fromWidth(70),
                      indicatorColor: kButtonColor,
                      innerColor: themeModel.isDark
                          ? kSecondaryColorDark
                          : kSecondaryColorLight,
                      current: mapModel.typeMenuItem == 0 ? 'Этаж' : 'Корпус',
                      values: const ['Этаж', 'Корпус'],
                      iconOpacity: 0.2,
                      borderColor: themeModel.isDark
                          ? kPrimaryColorDark
                          : kPrimaryColorLight,
                      borderRadius: BorderRadius.circular(20.0),
                      iconBuilder: (value, size) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Center(
                            child: Text(
                              value.toString(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline3,
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
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(0, 1),
                                    blurRadius: 3,
                                    blurStyle: BlurStyle.solid)
                              ],
                              indicatorColor: kButtonColor,
                              innerColor: themeModel.isDark
                                  ? kSecondaryColorDark
                                  : kSecondaryColorLight,
                              current: mapModel.floor,
                              values: mapModel.getFloors(mapModel.building),
                              iconOpacity: 0.2,
                              borderColor: themeModel.isDark
                                  ? kPrimaryColorDark
                                  : kPrimaryColorLight,
                              borderRadius: BorderRadius.circular(20.0),
                              iconBuilder: (value, size) {
                                return Center(
                                  child: Text(
                                    value.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline2,
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
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(0, 1),
                                    blurRadius: 3,
                                    blurStyle: BlurStyle.solid)
                              ],
                              indicatorColor: kButtonColor,
                              innerColor: themeModel.isDark
                                  ? kSecondaryColorDark
                                  : kSecondaryColorLight,
                              current: mapModel.building,
                              values: mapModel.buildings,
                              iconOpacity: 0.2,
                              borderColor: themeModel.isDark
                                  ? kPrimaryColorDark
                                  : kPrimaryColorLight,
                              borderRadius: BorderRadius.circular(20.0),
                              iconBuilder: (value, size) {
                                return Center(
                                  child: Text(
                                    value.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline2,
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
              return Lottie.asset('assets/loadingDragoAnimation.json');
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
    );
  }
}
