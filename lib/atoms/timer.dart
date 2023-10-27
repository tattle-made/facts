import 'package:facts/atoms/heading.dart';
import 'package:flutter/widgets.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animatedTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    _animatedTimer = CurvedAnimation(parent: _controller, curve: Curves.linear)
        .drive(Tween<double>(begin: 60, end: 0));

    _start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    _controller
      ..duration = const Duration(seconds: 60)
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Heading(_animatedTimer.value.floor().toString());
        },
      ),
    );
  }
}
