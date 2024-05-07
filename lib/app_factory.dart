import 'package:facts/manager_audio.dart';
import 'package:facts/manager_plausible_analytics.dart';
import 'package:facts/router_level.dart';

class AppFactory {
  final audioManager = ManagerAudio();
  final analyticsManager = PlausibleAnalytics();
  final levelRouter = RouterLevel(path: "1.0.0");

  void init() {
    audioManager.init();
    analyticsManager.init();
  }
}
