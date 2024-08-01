import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/models/itune_model.dart';

class MusicController extends GetxController {
  var isPlaying = false.obs;
  var isPaused = false.obs;
  var currentTrackIndex = 0.obs;
  var position = Duration().obs;
  var duration = Duration().obs;

  AudioPlayer audioPlayer = AudioPlayer();
  late ItunesController itunesController; // Add a reference to ItunesController

  @override
  void onInit() {
    super.onInit();
    itunesController = Get.find<ItunesController>(); // Initialize ItunesController
    audioPlayer.onDurationChanged.listen((d) => updateDuration(d));
    audioPlayer.onAudioPositionChanged.listen((p) => updatePosition(p));
  }

  void playPause(String url) {
    if (isPlaying.value && !isPaused.value) {
      audioPlayer.pause();
      isPaused.value = true;
    } else if (isPaused.value) {
      audioPlayer.resume();
      isPaused.value = false;
    } else {
      audioPlayer.play(url);
      isPlaying.value = true;
      isPaused.value = false;
    }
  }

  void stop() {
    audioPlayer.stop();
    isPlaying.value = false;
    isPaused.value = false;
  }

  void playNext() {
    if (itunesController.searchResults.isNotEmpty &&
        currentTrackIndex.value < itunesController.searchResults.length - 1) {
      currentTrackIndex.value++;
      playTrack(itunesController.searchResults[currentTrackIndex.value]);
    }
  }

  void playPrevious() {
    if (itunesController.searchResults.isNotEmpty &&
        currentTrackIndex.value > 0) {
      currentTrackIndex.value--;
      playTrack(itunesController.searchResults[currentTrackIndex.value]);
    }
  }

  void playTrack(ItunesModel track) {
    stop();
    playPause(track.previewUrl);
  }

  void updatePosition(Duration position) {
    this.position.value = position;
  }

  void updateDuration(Duration duration) {
    this.duration.value = duration;
  }
}
