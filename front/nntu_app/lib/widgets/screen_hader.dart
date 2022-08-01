import 'package:flutter/material.dart';
import 'package:nntu_app/constants.dart';

class ScreenHader extends StatelessWidget {
  final String title;
  const ScreenHader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 60,
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: kTextH1,
        ),
      ),
    );
  }
}
