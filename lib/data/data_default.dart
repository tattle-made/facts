import 'dart:io';

import 'package:facts/message_board/model/Message.dart';
import 'package:facts/data/model.dart';

var data = Content(type: ContentType.message, messages: <Message>[
  Message(text: "Unable to find any content", sender: "boss"),
]);
