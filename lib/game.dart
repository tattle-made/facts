import 'package:facts/player_lab/model/screen_playerlab.dart';
import 'package:facts/data/model.dart';
import 'package:facts/message_board/widget/message_board.dart';
import 'package:facts/player_lab/widget/test_lab.dart';
import 'package:facts/router_level.dart';
import 'package:flutter/widgets.dart';

class Game extends StatelessWidget {
  RouterLevel level;
  Game({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (level.content.type) {
      case ContentType.lab:
        // return ScreenPlayerLab(
        //   onFinish: () {},
        //   onEvent: () {},
        //   level: level,
        // );
        return TestLab(level: level, onFinish: () {}, onEvent: () {});
      case ContentType.message:
        return MessageBoard(level: level);
      default:
        return Text("Unexpected Level Value");
    }
  }
}
