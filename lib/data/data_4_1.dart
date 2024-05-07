import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/game/model/message_result.dart';
import 'package:facts/data/model.dart';
import 'package:facts/player_lab/image_comparator.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/comparator.dart';
import 'package:facts/player_lab/model/image.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:flutter/animation.dart';
import 'package:image_compare/image_compare.dart';
import 'dart:math';

// handline

var data = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(
          usesBrush: true,
          layers: [
            PlayerLabLayer(
                image: PlayerLabImage(
                    path: 'assets/p5l1.png', shaderPath: "shaders/smear.frag"),
                location: const Offset(0, 0),
                controls: [],
                allowZoom: false,
                allowPan: false,
                allowBrush: true),
          ],
          zoom: 1.0,
          pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: "assets/p5t.png",
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    comparator: Comparator(
        matchAlgorithm: EuclideanColorDistance(),
        match: 0.04,
        threshold: 0.0001),
    comparatorV2:
        (PlayerLabCanvas playerCanvas, PlayerLabCanvas targetCanvas) async {
      // var width = 360.0;
      // var height = 206.0;
      // double imageDiff = await compare(
      //     targetCanvas, width, height, playerCanvas, EuclideanColorDistance());
      // print(imageDiff);
      // var result = imageDiff < 0.0001;
      // print(result);
      // print(playerCanvas);
      var dice = Random().nextInt(2) == 0;
      return dice;
    },
    messageResult: MessageResult(
        success: MessagePopupScreen(title: "Horray", message: "You did it!"),
        failure: MessagePopupScreen(
            title: "Womp", message: "This could get people killed")));
