import 'dart:io';

import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/game/model/message_result.dart';
import 'package:facts/message_board/model/Message.dart';
import 'package:facts/data/model.dart';

var data = Content(
    type: ContentType.message,
    messages: <Message>[
      Message(text: "Unable to find any content", sender: "boss"),
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));
