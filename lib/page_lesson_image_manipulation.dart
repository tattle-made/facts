import 'dart:ui';

import 'package:facts/atoms/button.dart';
import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/paragraph.dart';
import 'package:facts/episode_food_vlogger_puzzles.dart';
import 'package:facts/image_forensic_slider.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/image.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:facts/player_lab/model/layer_config.dart';
import 'package:facts/player_lab/widget/test_art_board.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageLessonImageManipulation extends StatefulWidget {
  final Function? onFinish;
  const PageLessonImageManipulation({super.key, this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return _EpisodeState();
  }
}

class _EpisodeState extends State<PageLessonImageManipulation> {
  void redraw() {
    setState() {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: _Lesson(onFinish: widget.onFinish, redraw: redraw),
    );
  }
}

class _Lesson extends StatelessWidget {
  final Function? onFinish;
  Function redraw;
  _Lesson({super.key, this.onFinish, required this.redraw});

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
        // Paragraph(
        //     "\nYour name is \"Agent Eye\". Your goal is to become a detective and solve controversies on social media. Through this training module, you will learn new skills. \n"),
        Heading("Translation"),
        Paragraph(
            "Click and drag the apple to move it to the center of the canvas. You can Pinch-Zoom with both fingers to increase or decrease the size of the apple"),
        Container(height: 12),
        TestArtBoard(
          canvas: PlayerLabCanvas(layers: [
            PlayerLabLayer(
              image: PlayerLabImage(
                  path: 'assets/t1l1.png',
                  shaderPath: "shaders/shader_image.frag"),
              location: const Offset(0, 0),
              controls: [],
            ),
            PlayerLabLayer(
              image: PlayerLabImage(
                  path: 'assets/t1l2.png',
                  shaderPath: "shaders/shader_image.frag"),
              location: const Offset(0, 0),
              controls: [],
            ),
          ], zoom: 1.0, pan: const Offset(0, 0)),
          onChange: redraw,
        ),
        Container(height: 12),
        Heading("Contrast"),
        Paragraph(
            "You can click on some objects on your canvas to reveal additional manipulations you can perform on the image"),
        Container(height: 12),
        Container(
          padding: EdgeInsets.all(4),
          child: TestArtBoard(
              canvas: PlayerLabCanvas(layers: [
                PlayerLabLayer(
                    image: PlayerLabImage(
                        path: 'assets/p2l1.png',
                        shaderPath: "shaders/contrast.frag"),
                    location: const Offset(0, 0),
                    controls: [
                      ControlValueDoubleRange(
                          value: 1, min: -20, max: 5, label: 'Contrast')
                    ]),
              ], zoom: 1.0, pan: const Offset(0, 0)),
              onChange: redraw),
        ),
        Container(height: 24),
        AccentButton(
            label: "Done",
            onClick: () {
              onFinish?.call();
            }),
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
