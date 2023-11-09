import 'dart:ui';

class DrawnPath{
  var paths = List<List<Offset>>.empty(growable: true);
  int canvasWidth=0;
  int canvasHeight=0;

  DrawnPath();

  Offset _normalizePoint(Offset point){
    return Offset((point.dx/canvasWidth).toDouble(), (point.dy/canvasHeight).toDouble());
  }

  void setDimension(int w, int h){
    if(canvasWidth==0||canvasHeight==0){
      canvasWidth = w;
      canvasHeight = h;
    }
  }

  void initializeNewPath(){
    var newPath = List<Offset>.empty(growable: true);
    paths.add(newPath);
  }

  void addTo(int index, Offset point){
    paths[index].add(_normalizePoint(point));
  }

  void addToLast(Offset point){
    // Offset normalizedPoint = _normalizePoint(point);
    paths[paths.length-1].add(point);
    // var lastPath = paths[paths.length-1];
    // if(lastPath[lastPath.length-1] != normalizedPoint){
    //   lastPath.add(normalizedPoint);
    // }
  }
}