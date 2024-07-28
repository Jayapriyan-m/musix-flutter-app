import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isPaused = false;

  @override
  void onInit() {
    super.onInit();
    audioPlayer.onPlayerCompletion.listen((_) {
      isPlaying = false;
      isPaused = false;
      update();
    });
  }

  void playPause(String url) {
    if (isPlaying) {
      if (isPaused) {
        audioPlayer.resume();
        isPaused = false;
      } else {
        audioPlayer.pause();
        isPaused = true;
      }
    } else {
      audioPlayer.play(url);
      isPlaying = true;
    }
    update();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
