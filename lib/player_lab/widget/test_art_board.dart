import 'dart:ui' as ui;
import 'dart:ui';
import 'package:facts/player_lab/artboard_manager.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/widget/drawn_path.dart';
import 'package:facts/player_lab/widget/layer_compositor.dart';
import 'package:facts/player_lab/widget/layer_controls.dart';
import 'package:facts/player_lab/widget/wrapper_art_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../mask.dart';


class TestArtBoard extends StatefulWidget {
  late PlayerLabCanvas canvas;
  Function? onChange;

  TestArtBoard({super.key, required this.canvas, required this.onChange});

  @override
  State<TestArtBoard> createState() => _TestArtBoardState();
}

class _TestArtBoardState extends State<TestArtBoard> {
  late ArtBoardManager canvasGestureInteractionManager;
  late PlayerLabCanvas canvas;
  late Mask imageMask;
  bool showArtBoard = false;
  int selection = 1; // 1 is brush 0 is no brush;

  void loadResources() async {
    await canvas.initialize();
    imageMask = canvas.brushMask;
    setState(() {
      showArtBoard = true;
    });
  }

  void changeControl(){
    print('change control');
    widget.onChange!();
  }

  @override
  void initState() {
    super.initState();
    canvas = widget.canvas;
    canvasGestureInteractionManager = ArtBoardManager(canvas: canvas);
    canvas.selectionIndex = 0;
    loadResources();
  }

  void redraw(){
    setState(() {});
  }

  Future<void> _regenerateMask() async{
    canvas.brushMask.makeImageFromPath();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (showArtBoard){
      return Column(
        children: [
          GestureDetector(
            child: WrapperArtBoard(
                child: CustomPaint( painter: LayerCompositor(playerLab: canvas, imageMask: canvas.brushMask.imageBrushMask))
            ),
            onScaleStart: (details) {
              // print(details.pointerCount);

              if(details.pointerCount==1){
                if(selection==1){
                  print("initialize brush path");
                  canvas.brushMask.drawnPath.initializeNewPath();
                  canvas.brushMask.drawnPath.setDimension(MediaQuery.of(context).size.width.floor(), (170 / 297 * MediaQuery.of(context).size.width).floor());
                }else{
                  print("undefined 1");

                }
                // this is a brush stroke

              }else{
                canvasGestureInteractionManager.onScaleStart(details);
              }

              widget.onChange!();
              redraw();
              print("on scale start");

            },
            onScaleUpdate: (details) {
              // print(details.pointerCount);
              if(details.pointerCount==1){
                if(selection==1){
                  print("draw with brush");
                  canvas.brushMask.drawnPath.addToLast(details.localFocalPoint);
                  _regenerateMask();
                }else{
                  print("pan image instead");
                }
                // add to path
                //   paths.addToLast(details.localPosition);
                //   _regenerateImage();
              }else{
                canvasGestureInteractionManager.onScaleUpdate(details);
              }
              print("on scale update");

              widget.onChange!();
              redraw();
            },
            onScaleEnd: (details) {
              // print(details.pointerCount);
              if(details.pointerCount==1){
                if(selection==1){
                  print("end brush");
                }else{
                  print("undefined state 2   ");
                }
              }else{
                canvasGestureInteractionManager.onScaleEnd(details);
                // redraw();
              }
              print("on scale end");

              widget.onChange!();
              redraw();
            },
            onTapDown: (details) {
              canvasGestureInteractionManager.onTapDown(details);
              // redraw();
              print("on tap down");
              widget.onChange!();
            },
          ),
          LayerControls(
              controls: widget.canvas.layers![widget.canvas.selectionIndex].controls,
              onChange: changeControl
          )
        ],
      );
    }else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Container(
            height: 8,
          ),
          Text("Preparing Laboratory", style: TextStyle(color: Colors.white, fontSize: 24),)
        ],
      );
    }
  }
}




