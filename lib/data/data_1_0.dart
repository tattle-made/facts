import 'dart:io';

import 'package:facts/message_board/model/Message.dart';
import 'package:facts/data/model.dart';

var data = Content(type: ContentType.message, messages: <Message>[
  Message(
      text: "Are you following the news about Food Vlogger Masoorie's death?",
      sender: "boss"),
  Message(
      text:
          "Not really. I'm busy wrapping up my work so I can leave early and make it in time for my daughter's birthday party.",
      sender: "you"),
  Message(
      text:
          "I'm sorry you might have to stay late tonight. There's a lot of conspiracy theories about who murdered her going around on social media. We need your help.",
      sender: "boss"),
  Message(
      text: "It can't be that bad. How many theories are there?",
      sender: "you"),
  Message(
      text:
          "There's 5 already and if we don't bust them in time this could blow up",
      sender: "boss"),
]);
