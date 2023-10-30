// game level is captured by a string of format X.Y.Z
// X is the level number, Y denotes the type - message_board, lab and Z denotes the id of the unique screen within it

import 'package:facts/data/model.dart';
import 'package:facts/data/data.dart' as contentData;

final LEVEL_COUNT = 5;
final STARTING_PATH = "1.0.0";

class RouterLevel {
  String path;
  int levelNumber = 0;
  int pageType = 0;
  int contentIndex = 0;

  int contentLength = 0;
  Content content = contentData.content["default"]!;

  RouterLevel({required this.path}) {
    var components = path.split(".");
    levelNumber = int.parse(components[0]);
    pageType = int.parse(components[1]);
    contentIndex = int.parse(components[2]);
    updateContent();
  }

  updateContent() {
    print("Updating Content for $levelNumber.$pageType.$contentIndex");
    content = contentData.content["$levelNumber.$pageType"]!;
    if (content.type == ContentType.message) {
      contentLength = content.messages!.length;
    } else {
      contentLength = 1;
    }
  }

  Level getLevel() {
    var level =
        Level(levelNumber: levelNumber, type: pageType, content: content);

    return level;
  }

  IncrementResult _increment(int index, int length) {
    if (index < length - 1) {
      return IncrementResult(carry: false, newValue: index + 1);
    } else {
      return IncrementResult(carry: true, newValue: 0);
    }
  }

  RouterLevel nextLevel() {
    // print("$levelNumber.$pageType.$contentIndex.$contentLength");

    IncrementResult contentIdIncRes = _increment(contentIndex, contentLength);
    if (contentIdIncRes.carry) {
      IncrementResult pageTypeIncRes =
          _increment(pageType, ContentType.values.length);
      if (pageTypeIncRes.carry) {
        IncrementResult levelIncRes = _increment(levelNumber, LEVEL_COUNT);
        if (levelIncRes.carry) {
          path = STARTING_PATH;
          levelNumber = 1;
          pageType = 0;
          contentIndex = 0;
        } else {
          levelNumber = levelIncRes.newValue;
          pageType = 0;
          contentIndex = 0;
          updateContent();
        }
      } else {
        contentIndex = 0;
        pageType = pageTypeIncRes.newValue;
        updateContent();
      }
    } else {
      contentIndex = contentIdIncRes.newValue;
    }

    print("$levelNumber.$pageType.$contentIndex");
    return this;
  }
}

enum LevelType { messageBoard, lab }

class Level {
  int levelNumber;
  int type;
  Content content;

  Level({required this.levelNumber, required this.type, required this.content});
}

class IncrementResult {
  bool carry;
  int newValue;

  IncrementResult({required this.carry, required this.newValue});
}
