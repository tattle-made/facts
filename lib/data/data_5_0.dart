import 'dart:io';

import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/game/model/message_result.dart';
import 'package:facts/message_board/model/Message.dart';
import 'package:facts/data/model.dart';

var data = Content(
    type: ContentType.message,
    messages: <Message>[
      Message(
          text: "Congratulations on finishing this mission", sender: "boss"),
      Message(
          text:
              "You have shown satisfactory progress. You can join us from next monday. Keep looking out for new tasks in your inbox",
          sender: "you"),
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));
