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
              "Today we begin the first day of your training in our digital forensics lab. Are you excited?",
          sender: "boss"),
      Message(
          text: "Of course. Can't want to learn from you and the detective!",
          sender: "you"),
      Message(
          text: "Uh oh. We have one of those enthusiastic interns?",
          sender: "detective"),
      Message(
          text:
              "I think this intern will do just fine. @intern I am putting you on a breaking story. Food Vlogger Masoorie has died!",
          sender: "boss"),
      Message(
          imagePath: "assets/masoori-faint.gif", text: "hi", sender: "boss"),
      Message(
          text:
              " In the absence of a final word from the cops, social media is buzzing with all sorts of conspiracy theories about her death. I will collect these stories and handover to you two.",
          sender: "boss"),
      Message(
          text: "A food vlogger died. So what? Why am I working on this?",
          sender: "detective"),
      Message(
          text:
              "She's famous and her fans and detractors could cause unrest in the city.",
          sender: "boss"),
      Message(
          text:
              "Check out this image thats going viral. It says she died from drinking excessive alcohol while cooking.",
          sender: "boss"),
      Message(imagePath: "assets/p1t.png", text: "hi", sender: "boss"),
      Message(
          text: "That bottle of alcohol was clearly added there digitally.",
          sender: "detective"),
      Message(
          text: "Tell that to the 15,000 people who have shared this 😕",
          sender: "boss"),
      Message(
          text:
              "Alright then. I will setup the canvas for you @intern. But I have other pressing matters to look into. see if you can use the 'TRANSLATE' operation to match the manufactured image.",
          sender: "boss"),
      Message(text: "ummm. ok I will try 😬", sender: "you"),
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));
