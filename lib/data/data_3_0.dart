import 'dart:io';

import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/game/model/message_result.dart';
import 'package:facts/message_board/model/Message.dart';
import 'package:facts/data/model.dart';

var data = Content(
    type: ContentType.message,
    messages: <Message>[
      Message(text: "Can we go home now?", sender: "detective"),
      Message(
          text:
              "Not yet. A new conspiracy theory is taking hold amongst people. They are saying she was poisoned.",
          sender: "boss"),
      Message(imagePath: "assets/p4t.png", text: "hi", sender: "boss"),
      Message(
          text:
              "Members of the group evil_honey_731 say that she consumed expired honey",
          sender: "boss"),
      Message(text: "Expired honey does not turn blue", sender: "detective"),
      Message(
          text: "Tell that to the 80,000 people who have shared this image",
          sender: "boss"),
      Message(
          text:
              "@intern, do you know how to adjust tint and color on an image?",
          sender: "detective"),
      Message(text: "I'll be able to figure it out", sender: "you"),
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));
