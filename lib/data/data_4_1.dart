import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/game/model/message_result.dart';
import 'package:facts/data/model.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/comparator.dart';
import 'package:facts/player_lab/model/image.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:flutter/animation.dart';
import 'package:image_compare/image_compare.dart';

// handline

var data = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(
          usesBrush: true,
          layers: [
            PlayerLabLayer(
                image: PlayerLabImage(
                    path: 'assets/p5t.png', shaderPath: "shaders/smear.frag"),
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
      matchAlgorithm: PerceptualHash(),
      match: 0.04,
    ),
    messageResult: MessageResult(
        success: MessagePopupScreen(title: "Horray", message: "You did it!"),
        failure: MessagePopupScreen(
            title: "Womp", message: "This could get people killed")));
