import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';
import 'package:nntu_app/widgets/screen_hader.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toggle_switch/toggle_switch.dart';

// Карта вуза

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _categoryIndex = 0;
  int _selectedFloor = 1;
  int _selectedBuilding = 1;
  final _floor = [1, 2, 3];
  final _buildings = [1, 2, 3, 4, 5, 6];
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
                          values: _floor,
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
                          values: _buildings,
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
            child: PhotoView(
              imageProvider: const AssetImage('assets/1level non-active 6.png'),
              minScale: PhotoViewComputedScale.contained * 0.7,
              maxScale: PhotoViewComputedScale.covered * 2.0,
              enableRotation: true,
              backgroundDecoration: const BoxDecoration(color: kPrimaryColor),
              tightMode: true,
            ),
          ),
        ],
      ),
    );
  }
}


