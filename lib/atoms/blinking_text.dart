import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class BlinkingText extends StatefulWidget {
  const BlinkingText({Key? key}) : super(key: key);

  @override
  _BlinkingTextState createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation animatedOpacity;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animatedOpacity = ColorTween(
            begin: Color.fromARGB(255, 255, 0, 0),
            end: Color.fromARGB(0, 0, 0, 0))
        .animate(_controller);

    _start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    _controller.forward().then((value) => {
          _controller.reverse().then((value) => {_controller.repeat()})
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Text(
            "REC",
            style: GoogleFonts.pressStart2p(
                textStyle: TextStyle(
                    color: animatedOpacity.value,
                    fontSize: 18,
                    fontWeight: FontWeight.w800)),
          );
        },
      ),
    );
  }
}
