import 'package:facts/page_about.dart';
import 'package:facts/atoms/button.dart';
import 'package:facts/atoms/typography.dart';
import 'package:facts/game/model/page.dart' as facts_page;
import 'package:flutter/material.dart';

class PageHome extends StatelessWidget {
  Function onFinish;
  Function onChangePage;
  PageHome({Key? key, required this.onFinish, required this.onChangePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 24),
        Heading1PrimaryFontWhite("Factual Accuracy Checking Tutorials!"),
        Container(height: 24),
        Heading2PrimaryFontWhite(
            "An interactive resource to sharpen your critical thinking and media literacy skills"),
        Container(height: 32),
        AccentButtonFullWidth(
            label: "Lesson : Image Manipulation",
            onClick: () {
              onChangePage(facts_page.Page.LESSON);
            }),
        Container(height: 24),
        AccentButtonFullWidth(
            label: "Game : What killed Masoorie?",
            onClick: () {
              onChangePage(facts_page.Page.GAME);
            }),
        Container(height: 40),
        SimpleButton(
            label: "About",
            onClick: () {
              onChangePage(facts_page.Page.ABOUT);
            })
      ],
    );
  }
}
