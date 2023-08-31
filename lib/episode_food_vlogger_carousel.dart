import 'package:facts/lesson_food_vlogger.dart';
import 'package:facts/episode_food_vlogger_puzzles.dart';
import 'package:facts/image_forensic_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EpisodeFoodVloggerCarousel extends StatefulWidget {
  const EpisodeFoodVloggerCarousel({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<EpisodeFoodVloggerCarousel> {
  int puzzleNum = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('carousel'),
        Carousel(num: puzzleNum),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    puzzleNum--;
                  });
                },
                child: Text('<')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    puzzleNum++;
                  });
                },
                child: Text('>'))
          ],
        )
      ],
    );
  }
}

class Carousel extends StatelessWidget {
  int num = 0;

  Carousel({super.key, required this.num});

  @override
  Widget build(BuildContext context) {
    switch (num) {
      case 0:
        return ImageForensicSlider(
          imagePath1: "assets/snapchat_01.jpg",
          imagePath2: "assets/snapchat_02.jpg",
        );
      case 1:
        return EpisodeFoodVloggerPuzzles();
    }
    return ImageForensicSlider(
      imagePath1: "assets/snapchat_01.jpg",
      imagePath2: "assets/snapchat_02.jpg",
    );
  }
}
