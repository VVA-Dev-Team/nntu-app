import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/controllers/map_controller.dart';
import 'package:nntu_app/widgets/screen_hader.dart';
import 'package:toggle_switch/toggle_switch.dart';

// Карта вуза

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  int _categoryIndex = 0;
  int _selectedFloor = 1;
  int _selectedBuilding = 1;

  late AnimationController _controller;

  String getImageURL() {
    String imageURL = '';

    switch (_selectedBuilding) {
      case 1:
        break;
      default:
    }

    return '';
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
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
    return Container(
      color: kPrimaryColor,
      child: Column(
        children: [
          const ScreenHader(title: 'Навигация'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    cursorColor: kButtonColor,
                    style: kTextH2,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: 'Введите аудиторию..',
                      hintStyle: TextStyle(color: kTextColor),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 32),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Найти',
                    style: kTextH3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
              children: [
                ToggleSwitch(
                  initialLabelIndex: _categoryIndex,
                  cornerRadius: 10.0,
                  activeFgColor: kTextColor,
                  inactiveBgColor: kSecondaryColor,
                  inactiveFgColor: kTextColor,
                  totalSwitches: 2,
                  labels: const ['Этаж', 'Корпус'],
                  activeBgColors: const [
                    [Colors.blueAccent],
                    [Colors.blueAccent],
                  ],
                  onToggle: (index) {
                    setState(() {
                      _categoryIndex = index ?? 0;
                    });
                  },
                ),
                const SizedBox(width: 16),
                _categoryIndex == 0
                    ? Expanded(
                        child: AnimatedToggleSwitch<int>.size(
                          innerColor: kSecondaryColor,
                          current: _selectedFloor,
                          values: getFloors(_selectedBuilding),
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
                          onChanged: (i) => setState(() => _selectedFloor = i),
                        ),
                      )
                    : Expanded(
                        child: AnimatedToggleSwitch<int>.size(
                          innerColor: kSecondaryColor,
                          current: _selectedBuilding,
                          values: getBuildings(),
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
                          onChanged: (i) =>
                              setState(() => _selectedBuilding = i),
                        ),
                      ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ExtendedImage.network(
              'https://nntuapp.api.vvadev.ru/static/navigate/1_building/1101.png',
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
                    return Lottie.asset('assets/loadingDragoAnimation.json',
                        fit: BoxFit.fill);
                  case LoadState.completed:
                    _controller.forward();
                    return FadeTransition(
                      opacity: _controller,
                      child: ExtendedImage.network(
                        'https://nntuapp.api.vvadev.ru/static/navigate/1_building/1101.png',
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
        ],
      ),
    );
  }
}
