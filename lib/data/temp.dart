import 'dart:io';

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

var puzzleExposureData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/pzl2_02.png',
                shaderPath: "shaders/shader_translate.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(
                  value: 100, min: 0, max: 300, label: 'Exposure')
            ]),
        PlayerLabLayer(
            image: PlayerLabImage(path: 'assets/pzl2_01.png'),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/pzl2_03.png"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

var puzzleContrastData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/apple.jpeg', shaderPath: "shaders/contrast.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(
                  value: 0, min: 0, max: 10, label: 'Contrast')
            ]),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/apple.jpeg"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

var puzzleWhiteBalanceData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/apple.jpeg',
                shaderPath: "shaders/whitebalance.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(value: 0, min: -5, max: 5, label: 'Temp'),
              ControlValueDoubleRange(value: 0, min: -5, max: 5, label: 'Tint')
            ]),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/apple.jpeg"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

var puzzleSplitToneData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/apple.jpeg',
                shaderPath: "shaders/splittone.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(
                  label: 'Shadows', value: 0, min: 0, max: 1),
              ControlValueDoubleRange(
                  label: 'Highlights', value: 0, min: 0, max: 1),
              ControlValueDoubleRange(
                  label: 'Balance', value: 0, min: 0, max: 1),
            ]),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/apple.jpeg"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

var puzzleSaturationData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/apple.jpeg',
                shaderPath: "shaders/saturation.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(
                  label: 'Saturation', value: 0, min: 0, max: 1),
              // ControlValueDoubleRange(label: 'Highlights', value: 0, min:0, max:1),
              // ControlValueDoubleRange(label: 'Balance', value: 0, min:0, max:1),
            ]),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/apple.jpeg"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

var puzzleBlurData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/apple.jpeg', shaderPath: "shaders/blur.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(
                  label: 'Blur', value: 0, min: 0, max: 250),
              // ControlValueDoubleRange(label: 'Highlights', value: 0, min:0, max:1),
              // ControlValueDoubleRange(label: 'Balance', value: 0, min:0, max:1),
            ]),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/apple.jpeg"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

var puzzleHazeData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/apple.jpeg', shaderPath: "shaders/levels.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(label: 'hzds', value: 0, min: 0, max: 1),
              ControlValueDoubleRange(label: 'slope', value: 0, min: 0, max: 1),
              ControlValueDoubleRange(label: 'color', value: 0, min: 0, max: 1),
              // ControlValueDoubleRange(label: 'Highlights', value: 0, min:0, max:1),
              // ControlValueDoubleRange(label: 'Balance', value: 0, min:0, max:1),
            ]),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/apple.jpeg"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

var puzzleSimpleBlurData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/apple.jpeg',
                shaderPath: "shaders/simple_blur.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(label: 'a', value: 0, min: -10, max: 10),
              ControlValueDoubleRange(label: 'b', value: 0, min: -10, max: 10),
              ControlValueDoubleRange(label: 'c', value: 0, min: -10, max: 10),
              ControlValueDoubleRange(label: 'd', value: 0, min: -10, max: 10),
              // ControlValueDoubleRange(label: 'Highlights', value: 0, min:0, max:1),
              // ControlValueDoubleRange(label: 'Balance', value: 0, min:0, max:1),
            ]),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/apple.jpeg"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

var puzzleSmearData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/smear_og.png', shaderPath: "shaders/smear.frag"),
            location: const Offset(0, 0),
            controls: [],
            allowZoom: false,
            allowPan: false,
            allowBrush: true),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: "assets/apple.jpeg", shaderPath: "shaders/smear.frag"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

var puzzleTest = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/dash.jpg', shaderPath: "shaders/smear.frag"),
            location: const Offset(0, 0),
            controls: [],
            allowZoom: false,
            allowPan: false,
            allowBrush: true),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/apple.jpeg"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

// move bottle on top of microwave
var puzzleOneData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/apple.jpeg',
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: []),
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/bottle.png',
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: "assets/p1_target.png",
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

// control exposure of microwave
var puzzleTwoData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/apple.jpeg', shaderPath: "shaders/contrast.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(
                  value: 0, min: 0, max: 10, label: 'Contrast')
            ]),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/apple.jpeg"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

// smear test
var puzzleThreeData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/p5t.png', shaderPath: "shaders/smear.frag"),
            location: const Offset(0, 0),
            controls: [],
            allowZoom: false,
            allowPan: false,
            allowBrush: true),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/apple.jpeg"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

// flip text
var puzzleFourData = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/pzl_caserole.png',
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: [],
            allowZoom: true,
            allowPan: true),
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/pzl_kirkas_3.png',
                shaderPath: "shaders/shader_pan.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(value: 0, min: -5, max: 5, label: 'Flip')
            ],
            allowZoom: true,
            allowPan: true)
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(path: "assets/pzl_caserole.png"),
            location: const Offset(0, 0),
            controls: [],
            allowZoom: false,
            allowPan: false)
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    messageResult: MessageResult(
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

var pzlOne = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/p1l1.png',
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: []),
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/p1l3.png',
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: []),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: "assets/p1t.png",
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
        success: MessagePopupScreen(), failure: MessagePopupScreen()));

var pzlThree = Content(
  type: ContentType.lab,
  labCanvas: [
    PlayerLabCanvas(layers: [
      PlayerLabLayer(
          image: PlayerLabImage(
              path: 'assets/p3l1.png', shaderPath: "shaders/shader_image.frag"),
          location: const Offset(0, 0),
          controls: []),
    ], zoom: 1.0, pan: const Offset(0, 0)),
    PlayerLabCanvas(layers: [
      PlayerLabLayer(
          image: PlayerLabImage(
              path: "assets/p3t.png", shaderPath: "shaders/shader_image.frag"),
          location: const Offset(0, 0),
          controls: [])
    ], zoom: 1.0, pan: const Offset(0, 0))
  ],
  messageResult: MessageResult(
      success: MessagePopupScreen(), failure: MessagePopupScreen()),
);

// puzzleSmearData

// puzzleFourData

// saturation, splittone

var pzlHandLine = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/p5t.png', shaderPath: "shaders/smear.frag"),
            location: const Offset(0, 0),
            controls: [],
            allowZoom: false,
            allowPan: false,
            allowBrush: true),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: "assets/p5t.png", shaderPath: "shaders/smear.frag"),
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
            title: "Womp", message: "That was embarrasing")));

// var data = pzlHandLine;
var data = pzlOne;
