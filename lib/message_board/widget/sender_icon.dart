import 'package:flutter/widgets.dart';

class SenderIcon extends StatelessWidget {
  String sender = "you";
  SenderIcon({Key? key, required this.sender}) : super(key: key);

  String getImagePath(String sender) {
    switch (sender) {
      case "you":
        return "assets/dp_02.png";
      case "boss":
        return "assets/dp_03.png";
      case "detective":
        return "assets/dp_04.png";
      default:
        return "assets/dp_01.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ClipOval(
        child: Image.asset(getImagePath(sender)),
      ),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }
}
