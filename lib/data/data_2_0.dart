import 'dart:io';

import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/game/model/message_result.dart';
import 'package:facts/message_board/model/Message.dart';
import 'package:facts/data/model.dart';

var data = Content(
    type: ContentType.message,
    messages: <Message>[
      Message(
          text:
              "Please tell me this vlogger business is over and we can all go home now?",
          sender: "detective"),
      Message(text: "Far from it. Its only getting crazier", sender: "boss"),
      Message(
          text:
              "This image was shared on a group called 'spirits_united_666'. It has already been shared by 30,432 people.",
          sender: "boss"),
      Message(imagePath: "assets/p2t.png", text: "hi", sender: "boss"),
      Message(
          text: "This is rudimentary use of exposure settings on the image.",
          sender: "detective"),
      Message(text: "Can you explain that to the intern?", sender: "boss"),
      Message(text: "You think you can handle it?", sender: "detective"),
      Message(text: "uhh... I can try", sender: "you"),
      Message(
          text: "Go to the lab. I'll prep the canvas for you.",
          sender: "detective"),
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));
