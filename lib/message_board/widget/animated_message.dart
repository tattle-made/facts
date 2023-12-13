import 'package:facts/atoms/button.dart';
import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/theme.dart';
import 'package:facts/atoms/typography.dart';
import 'package:facts/message_board/model/Message.dart';
import 'package:facts/message_board/widget/sender_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class AnimatedMessage extends StatefulWidget {
  late Message message;

  AnimatedMessage({Key? key, required this.message}) : super(key: key);

  @override
  State<AnimatedMessage> createState() => _State();
}

class _State extends State<AnimatedMessage> with TickerProviderStateMixin {
  late AnimationController _typingAnimationController;
  late Animation<double> _typingAnimation;

  @override
  void initState() {
    super.initState();

    _typingAnimationController = AnimationController(vsync: this);

    _typingAnimation = CurvedAnimation(
            parent: _typingAnimationController,
            curve: const Interval(0.0, 0.4, curve: Curves.decelerate),
            reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut))
        .drive(
            Tween<double>(begin: 0.0, end: widget.message.text!.length * 1.0));

    _start();
  }

  @override
  void dispose() {
    _typingAnimationController.dispose();
    super.dispose();
  }

  void _start() {
    _typingAnimationController
      ..duration = const Duration(milliseconds: 1500)
      ..forward();
  }

  void _reset() {
    _typingAnimationController
      ..duration = const Duration(milliseconds: 150)
      ..reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      AnimatedBuilder(
          animation: _typingAnimationController,
          builder: (context, child) {
            return Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Row(
                  children: [
                    SenderIcon(sender: widget.message.sender),
                    Container(
                      child: SenderLabel(widget.message.sender),
                      margin: EdgeInsets.fromLTRB(8, 8, 0, 0),
                    ),
                  ],
                ),
                Container(
                  height: 18,
                ),
                widget.message.imagePath == null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Heading2Black(widget.message.text!
                            .substring(0, (_typingAnimation.value).floor())))
                    : Container(),
                widget.message.imagePath != null
                    ? Image.asset(
                        widget.message.imagePath ?? "assets/size_03.png")
                    : Container()
              ]),
            );
          })
    ]);
  }
}
