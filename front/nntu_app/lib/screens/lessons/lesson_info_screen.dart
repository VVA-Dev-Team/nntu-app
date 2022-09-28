import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nntu_app/models/lessons_model.dart';
import 'package:nntu_app/widgets/screen_scaffold.dart';
import 'package:photo_view/photo_view.dart';

class LessonInfoScreen extends StatelessWidget {
  final Schedule schedule;
  const LessonInfoScreen({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> rooms = schedule.room.split(',');
    return ScreenScaffold(
        disableNavbar: true,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    schedule.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    schedule.type.toUpperCase(),
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              ),
              Text(
                '${schedule.startTime ~/ 60}:${schedule.startTime % 60} - ${schedule.stopTime ~/ 60}:${schedule.stopTime.remainder(60) < 10 ? 0 : ''}${schedule.stopTime.remainder(60)}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          schedule.weeks.contains(-2) ? 'ЧЕТНЫЕ НЕДЕЛИ' : null,
                      style: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: schedule.weeks.contains(-2) &&
                              schedule.weeks.contains(-1)
                          ? ' + '
                          : null,
                      style: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: schedule.weeks.contains(-1)
                          ? 'НЕЧЕТНЫЕ НЕДЕЛИ'
                          : null,
                      style: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ПРЕПОДАВАТЕЛЬ',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    schedule.teacher,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'АУДИТОРИИ',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    schedule.room,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) => SizedBox(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: PhotoView(
                        disableGestures: true,
                        initialScale: PhotoViewComputedScale.contained * 1,
                        backgroundDecoration:
                            const BoxDecoration(color: Colors.transparent),
                        imageProvider: AssetImage(
                            'assets/navigate/${int.parse(rooms[index]) ~/ 1000}/${int.parse(rooms[index])}.png'),
                      ),
                    )),
                separatorBuilder: ((context, index) => const Divider()),
                itemCount: rooms.length,
              ),
            ],
          ),
        )),
        title: 'Расписание');
  }
}
