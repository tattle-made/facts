import 'dart:io';

import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/game/model/message_result.dart';
import 'package:facts/message_board/model/Message.dart';
import 'package:facts/data/model.dart';

var data = Content(
    type: ContentType.message,
    messages: <Message>[
      Message(text: "Have the rumours settled down?", sender: "detective"),
      Message(
          text:
              "Most of them have but on the fringes you see some outrageous ones",
          sender: "boss"),
      Message(
          text:
              "Members of horoscope_is_bae are claiming that her life line was pre destined to be cut short. As seen by the lines on her hand",
          sender: "boss"),
      Message(imagePath: "assets/p5t.png", text: "hi", sender: "boss"),
      Message(
          text:
              "This is beneath me. @intern you know how to use the smudge tool? Just rub your finger on the missing hand line till it matches the target image.",
          sender: "detective"),
      Message(text: "This looks tricky", sender: "you"),
      Message(text: "We trust you now", sender: "boss"),
      Message(text: "Thank you 😭", sender: "you"),
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));
