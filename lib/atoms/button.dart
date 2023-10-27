import 'package:flutter/material.dart';

Widget Button({label, onClick}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(255, 42, 20, 27),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 178, 43, 42),
                spreadRadius: 2.0,
                blurRadius: 11.2),
            BoxShadow(color: Colors.red, spreadRadius: 1.0),
          ]),
      child: Text(label,
          style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
              color: Color.fromARGB(255, 238, 204, 0))),
    ),
  );
}

Widget AccentButton({label, onClick}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Color.fromARGB(255, 238, 204, 0)),
      child: Text(label,
          style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
              color: Color.fromARGB(255, 42, 20, 27))),
    ),
  );
}
