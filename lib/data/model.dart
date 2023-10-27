import 'package:facts/message_board/model/Message.dart';
import 'package:facts/player_lab/model/canvas.dart';

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

  Content({required this.type, this.messages, this.labCanvas});
}
