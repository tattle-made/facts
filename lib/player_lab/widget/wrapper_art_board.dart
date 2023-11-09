import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WrapperArtBoard extends StatelessWidget {
  Widget child;
  WrapperArtBoard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 170 / 297 * MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 178, 43, 42),
                  spreadRadius: 4.0,
                  blurRadius: 6.2),
              BoxShadow(color: Colors.red, spreadRadius: 1.0),
            ],
            backgroundBlendMode: BlendMode.colorBurn),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: child,
        ),
      ),
    );
  }
}
