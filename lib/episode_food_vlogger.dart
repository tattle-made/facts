import 'package:facts/episode_food_vlogger_puzzles.dart';
import 'package:facts/image_forensic_slider.dart';
import 'package:flutter/material.dart';

class EpisodeFoodVlogger extends StatefulWidget {
  const EpisodeFoodVlogger({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EpisodeState();
  }
}

class _EpisodeState extends State<EpisodeFoodVlogger> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.all(12.0),
      child: _Lesson(),
    );
  }
}

class _Lesson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lessons',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
        ),
        Text(
            'Photographs are a powerful medium. They leave a lasting impression on us. We enjoy them more than text and now increasingly rely on them to inform and educate us. \n\n'),
        Text(
            'The story that a picture tells is determined by who took the picture, what is in it and who is seeing the picture. In our present culture of making memes and image resharing, it is also determined by who shared the picture and what additional context they have added to it to alter its meaning.\n\n'),
        Text(
            'People often make changes to an image captured by the Camera to alter its meaning. It could be an adjustment to brightness of the picture to make the subject clearer or cropping the image to make the subject more prominent.\n\n'),
        Text('Sometimes it can be used to make the pictures look better \n\n'),
        ImageForensicSlider(),
        Text('Sometimes they are used to make the pictures stylish\n\n'),
        ImageForensicSlider(),
        const Text(
            'Sometimes they are used to alter the meaning of a photo completely\n\n'),
        ImageForensicSlider(),
        const Text(
            'These digital manipulation techniques can sometimes be used to spread misinformation. For a media literate person, it is important to distinguish between the objective description and the subjective interpretation of a photo. Thankfully, these same tools and techniques can be used to investigate image manipulation. \n\n'),
        const Text('We will learn about them by solving a murder mystery!'),
        ElevatedButton(
            onPressed: () {
              print('hi');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EpisodeFoodVloggerPuzzles()));
            },
            child: Text('Click'))
      ],
    );
  }
}
