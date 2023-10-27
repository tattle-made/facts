import 'package:facts/atoms/button.dart';
import 'package:facts/message_board/model/Message.dart';
import 'package:facts/message_board/widget/animated_message.dart';
import 'package:facts/router_level.dart';
import 'package:flutter/widgets.dart';

import '../../atoms/heading.dart';

class MessageBoard extends StatefulWidget {
  final RouterLevel level;
  const MessageBoard({Key? key, required this.level}) : super(key: key);

  @override
  _MessageBoardState createState() => _MessageBoardState();
}

class _MessageBoardState extends State<MessageBoard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AnimatedMessage(
            message: widget.level.content.messages![widget.level.contentIndex],
            key: ValueKey(widget.level.contentIndex)),
      ],
    );
  }
}
