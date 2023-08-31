import 'dart:ui';

import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/paragraph.dart';
import 'package:facts/episode_food_vlogger_puzzles.dart';
import 'package:facts/image_forensic_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonFoodVlogger extends StatefulWidget {
  final Function? onFinish;
  const LessonFoodVlogger({super.key, this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return _EpisodeState();
  }
}

class _EpisodeState extends State<LessonFoodVlogger> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 201, 203, 163),
      padding: const EdgeInsets.all(12.0),
      child: _Lesson(onFinish: widget.onFinish),
    );
  }
}

class _Lesson extends StatelessWidget {
  final Function? onFinish;
  const _Lesson({super.key, this.onFinish});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Heading("Image\nManipulation"),
        Paragraph(
            '\nPhotographs are a powerful medium. They leave a lasting impression on us. We enjoy them more than text and now increasingly rely on them to inform and educate us. \n'),
        Paragraph(
            "The story that a picture tells is determined by who took the picture, what is in it and who is seeing the picture. In our present culture of making memes and image resharing, it is also determined by who shared the picture and what additional context they have added to it to alter its meaning.\n"),
        Paragraph(
            "People often make modifications to an image captured by the Camera. It could be an adjustment to brightness of the picture to make the subject clearer or cropping the image to make the subject more prominent.\n"),
        Paragraph(
            "Sometimes it can be used to make minor modifications to how you look\n"),
        ImageForensicSlider(
          imagePath1: "assets/facetune_01.jpg",
          imagePath2: "assets/facetune_02.jpg",
        ),
        Paragraph("\nSometimes they are used to make the pictures stylish\n"),
        ImageForensicSlider(
          imagePath1: "assets/snapchat_01.jpg",
          imagePath2: "assets/snapchat_02.jpg",
        ),
        Paragraph(
            "\nSometimes they are used to alter the meaning of a photo completely\n"),
        ImageForensicSlider(
          imagePath1: "assets/paul_01.png",
          imagePath2: "assets/paul_02.png",
        ),
        Paragraph(
            "\nThese digital manipulation techniques can sometimes be used to spread misinformation. For a media literate person, it is important to distinguish between the objective description and the subjective interpretation of a photo. Thankfully, these same tools and techniques can be used to investigate image manipulation. \n"),
        Paragraph("\nWe will learn about them by solving a murder mystery!\n"),
        GestureDetector(
            onTap: () {
              onFinish?.call();
            },
            child: Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 225, 168),
                  border: Border.all(
                      color: const Color.fromARGB(255, 255, 0, 0), width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(16.0))),
              child: const Row(
                children: [
                  const Icon(
                    Icons.play_arrow_outlined,
                    color: Color.fromARGB(255, 114, 61, 70),
                    size: 48.0,
                    semanticLabel: 'Draw Rectangle',
                  ),
                  const Text("Play")
                ],
              ),
            )),
        const SizedBox(
          height: 100,
          width: 20,
        )
      ],
    );
  }
}

var paraStyle = GoogleFonts.raleway(
    textStyle: TextStyle(
        color: Color.fromARGB(255, 71, 45, 48),
        fontSize: 16.0,
        height: 1.2,
        fontWeight: FontWeight.w600));
