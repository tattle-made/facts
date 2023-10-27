import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import "package:universal_html/html.dart" as html;
import 'package:http/http.dart' as http;
import 'package:fk_user_agent/fk_user_agent.dart';

class PlausibleAnalytics {
  String userAgent = "";
  var client = http.Client();

  void init() async {
    if (kIsWeb) {
      print('we are on web platform');
      try {
        userAgent = html.window.navigator.userAgent;
        // print(userAgent);
      } on PlatformException {
        print('failed to get useragent or platform');
      }
    } else {
      await FkUserAgent.init();
      userAgent = FkUserAgent.userAgent!;
      // print("===");
      // print(userAgent);
    }
  }

  void logStart() async {
    // print(userAgent);
    if (userAgent != "") {
      await client.post(Uri.parse("https://plausible.io/api/event"),
          headers: {
            'User-Agent': userAgent ?? '',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "name": "game_actions",
            "url": "http://fact",
            "domain": "facts",
            "props": jsonEncode({"name": "start"})
          }));
    }
  }

  void logEnd() async {
    if (userAgent != "") {
      await client.post(Uri.parse("https://plausible.io/api/event"),
          headers: {
            'User-Agent': userAgent ?? '',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "name": "game_actions",
            "url": "http://fact",
            "domain": "facts",
            "props": jsonEncode({"name": "end"})
          }));
    }
  }

  void logHelp() async {
    if (userAgent != "") {
      await client.post(Uri.parse("https://plausible.io/api/event"),
          headers: {
            'User-Agent': userAgent ?? '',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "name": "game_actions",
            "url": "http://fact",
            "domain": "facts",
            "props": jsonEncode({"name": "help"})
          }));
    }
  }

  void logLevel(int level) async {
    if (kIsWeb && userAgent != "") {
      await client.post(Uri.parse("https://plausible.io/api/event"),
          headers: {
            'User-Agent': userAgent ?? '',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "name": "game_actions",
            "url": "http://fact",
            "domain": "facts",
            "props": jsonEncode({"name": "level", "value": level})
          }));
    }
  }
}
