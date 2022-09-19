import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:nntu_app/models/init_model.dart';
import 'package:provider/provider.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "ERASER",
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        // pathImage: "images/photo_eraser.png",
        backgroundColor: const Color(0xfff5a623),
      ),
    );
    slides.add(
      Slide(
        title: "PENCIL",
        description:
            "Ye indulgence unreserved connection alteration appearance",
        // pathImage: "images/photo_pencil.png",
        backgroundColor: const Color(0xff203152),
      ),
    );
    slides.add(
      Slide(
        title: "RULER",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        // pathImage: "images/photo_ruler.png",
        backgroundColor: const Color(0xff9932CC),
      ),
    );
  }

  onDonePress(BuildContext context) {
    final initModel = Provider.of<InitModel>(context);
    // initModel.setInstructionScreen();
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
    
      slides: slides,
      onDonePress: onDonePress(context),
    );
  }
}
