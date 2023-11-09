import 'dart:io';

import 'package:facts/message_board/model/Message.dart';
import 'package:facts/data/model.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/image.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:facts/player_lab/model/layer_config.dart';
import 'package:flutter/animation.dart';

var puzzleExposureData = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/pzl2_02.png', shaderPath: "shaders/shader_translate.frag"),
        location: const Offset(0, 0), controls: [ControlValueDoubleRange(value: 100, min:0, max:300, label: 'Exposure')]),
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/pzl2_01.png'),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0)),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/pzl2_03.png"),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0))
]);

var puzzleContrastData = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/apple.jpeg', shaderPath: "shaders/contrast.frag"),
        location: const Offset(0, 0), controls: [ControlValueDoubleRange(value: 0, min:0, max:10, label: 'Contrast')]),
  ], zoom: 1.0, pan: const Offset(0, 0)),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/apple.jpeg"),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0))
]);

var puzzleWhiteBalanceData = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/apple.jpeg', shaderPath: "shaders/whitebalance.frag"),
        location: const Offset(0, 0), controls: [ControlValueDoubleRange(value: 0, min:-5, max:5, label: 'Temp'), ControlValueDoubleRange(value: 0, min:-5, max:5 , label: 'Tint')]),
  ], zoom: 1.0, pan: const Offset(0, 0)),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/apple.jpeg"),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0))
]);

var puzzleSplitToneData = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/apple.jpeg', shaderPath: "shaders/splittone.frag"),
        location: const Offset(0, 0), controls: [
          ControlValueDoubleRange(label: 'Shadows', value: 0, min:0, max:1),
          ControlValueDoubleRange(label: 'Highlights', value: 0, min:0, max:1),
          ControlValueDoubleRange(label: 'Balance', value: 0, min:0, max:1),
    ]),
  ], zoom: 1.0, pan: const Offset(0, 0)),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/apple.jpeg"),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0))
]);

var puzzleSaturationData = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/apple.jpeg', shaderPath: "shaders/saturation.frag"),
        location: const Offset(0, 0), controls: [
      ControlValueDoubleRange(label: 'Saturation', value: 0, min:0, max:1),
      // ControlValueDoubleRange(label: 'Highlights', value: 0, min:0, max:1),
      // ControlValueDoubleRange(label: 'Balance', value: 0, min:0, max:1),
    ]),
  ], zoom: 1.0, pan: const Offset(0, 0)),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/apple.jpeg"),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0))
]);

var puzzleBlurData = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/apple.jpeg', shaderPath: "shaders/blur.frag"),
        location: const Offset(0, 0), controls: [
      ControlValueDoubleRange(label: 'Blur', value: 0, min:0, max:250),
      // ControlValueDoubleRange(label: 'Highlights', value: 0, min:0, max:1),
      // ControlValueDoubleRange(label: 'Balance', value: 0, min:0, max:1),
    ]),
  ], zoom: 1.0, pan: const Offset(0, 0)),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/apple.jpeg"),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0))
]);

var puzzleHazeData = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/apple.jpeg', shaderPath: "shaders/levels.frag"),
        location: const Offset(0, 0), controls: [
          ControlValueDoubleRange(label: 'hzds', value: 0, min:0, max:1),
          ControlValueDoubleRange(label: 'slope', value: 0, min:0, max:1),
          ControlValueDoubleRange(label: 'color', value: 0, min:0, max:1),
          // ControlValueDoubleRange(label: 'Highlights', value: 0, min:0, max:1),
          // ControlValueDoubleRange(label: 'Balance', value: 0, min:0, max:1),
    ]),
  ], zoom: 1.0, pan: const Offset(0, 0)),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/apple.jpeg"),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0))
]);

var puzzleSimpleBlurData = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/apple.jpeg', shaderPath: "shaders/simple_blur.frag"),
        location: const Offset(0, 0), controls: [
      ControlValueDoubleRange(label: 'a', value: 0, min:-10, max:10),
      ControlValueDoubleRange(label: 'b', value: 0, min:-10, max:10),
      ControlValueDoubleRange(label: 'c', value: 0, min:-10, max:10),
      ControlValueDoubleRange(label: 'd', value: 0, min:-10, max:10),
      // ControlValueDoubleRange(label: 'Highlights', value: 0, min:0, max:1),
      // ControlValueDoubleRange(label: 'Balance', value: 0, min:0, max:1),
    ]),
  ], zoom: 1.0, pan: const Offset(0, 0)),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/apple.jpeg"),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0))
]);


var puzzleSmearData = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(
      layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: 'assets/smear_og.png', shaderPath: "shaders/smear.frag"),
            location: const Offset(0, 0),
            controls: [],
            allowZoom: false,
            allowPan: false
        ),
      ],
      zoom: 1.0,
      pan: const Offset(0, 0)
  ),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/apple.jpeg"),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0))
]);

var puzzleTest = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(
      layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: 'assets/apple.jpeg', shaderPath: "shaders/smear.frag"),
            location: const Offset(0, 0),
            controls: [],
            allowZoom: false,
            allowPan: false
        ),
      ],
      zoom: 1.0,
      pan: const Offset(0, 0)
  ),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/apple.jpeg"),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0))
]);

var data = puzzleTest;