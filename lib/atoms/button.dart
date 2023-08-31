import 'package:flutter/material.dart';

Widget Button({label, onClick}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Color.fromARGB(255, 226, 109, 92)),
      child: const Text("Next",
          style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 24.0,
              color: Color.fromARGB(255, 255, 225, 168))),
    ),
  );
}
