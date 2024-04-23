import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/game/model/message_result.dart';
import 'package:facts/message_board/model/Message.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/comparator.dart';

enum ContentType { message, lab }
// result

class LabContentConfig {
  int id;

  LabContentConfig({required this.id});
}

class Content {
  ContentType? type;
  List<Message>? messages;
  List<PlayerLabCanvas>? labCanvas;
  Comparator? comparator;
  MessageResult messageResult;
  Function? comparatorV2;

  Content(
      {required this.type,
      this.messages,
      this.labCanvas,
      this.comparator,
      required this.messageResult,
      this.comparatorV2});
}
