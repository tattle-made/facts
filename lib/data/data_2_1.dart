import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/game/model/message_result.dart';
import 'package:facts/data/model.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/comparator.dart';
import 'package:facts/player_lab/model/image.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:facts/player_lab/model/layer_config.dart';
import 'package:flutter/animation.dart';
import 'package:image_compare/image_compare.dart';
import 'package:facts/player_lab/comparator_utils.dart';

// the ghost in microwave puzzle

var data = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/p2l1.png', shaderPath: "shaders/contrast.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(
                  value: 1, min: -5, max: 5, label: 'Exposure')
            ]),
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/p2l2.png',
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: []),
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/p2l3.png',
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: []),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: "assets/p2t.png",
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    comparator: Comparator(
      matchAlgorithm: PerceptualHash(),
      match: 0.04,
    ),
    comparatorV2: (PlayerLabCanvas playerCanvas, PlayerLabCanvas targetCanvas) {
      ControlValueType? exposureControl = playerCanvas.layers?[0].controls[0];
      var exposureStatus =
          isValueAround(-2.76, exposureControl?.value as double, 2.0);

      Offset? bgOffset = playerCanvas!.layers?[0].location;
      var bgLocationStatus = isAround(const Offset(0, 0), bgOffset!, 1.0);

      Offset? redCircleOffset = playerCanvas!.layers?[1].location;
      var redCircleStatus =
          isAround(const Offset(36.0, 43.0), redCircleOffset!, 20.0);

      double? redCircleZoom = playerCanvas!.layers?[1].zoom;
      var redCircleZoomStatus = isValueAround(1.26, redCircleZoom!, 2.0);

      Offset? bannerLocation = playerCanvas!.layers?[2].location;
      var bannerLocationStatus =
          isAround(const Offset(180, 20), bannerLocation!, 50);

      print(playerCanvas);
      print(exposureStatus);
      print(bgLocationStatus);
      print(redCircleStatus);
      print(redCircleZoomStatus);
      print(bannerLocationStatus);
      return exposureStatus &&
          bgLocationStatus &&
          redCircleStatus &&
          redCircleZoomStatus &&
          bannerLocationStatus;
    },
    messageResult: MessageResult(
        success: MessagePopupScreen(
            title: "wow", message: "I am surprised with your progress"),
        failure: MessagePopupScreen(
            title: "ooops", message: "10 people died at the demonstration")));
