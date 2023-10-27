import 'package:audioplayers/audioplayers.dart';

class ManagerAudio {
  final playerMain = AudioPlayer()..setReleaseMode(ReleaseMode.loop);
  final playerSuccess = AudioPlayer()..setReleaseMode(ReleaseMode.loop);
  final playerFailure = AudioPlayer()..setReleaseMode(ReleaseMode.loop);

  void init() {
    playerMain.setSource(AssetSource("bg-loop.wav"));
    playerSuccess.setSource(AssetSource("bg-loop-success.wav"));
    playerFailure.setSource(AssetSource("bg-loop-failure.wav"));
  }

  void mute() {
    playerSuccess.stop();
    playerFailure.stop();
    playerMain.stop();
  }

  void playMain() {
    playerSuccess.stop();
    playerFailure.stop();
    playerMain.resume();
  }

  void playSuccess() {
    playerMain.stop();
    playerFailure.stop();
    playerSuccess.resume();
  }

  void playFailure() {
    playerMain.stop();
    playerSuccess.stop();
    playerFailure.resume();
  }
}
