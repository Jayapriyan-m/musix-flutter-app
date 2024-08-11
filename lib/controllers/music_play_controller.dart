import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/models/itune_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicController extends GetxController {
  // keeping track of whether music is currently playing or not
  var isPlaying = false.obs;
  // keeping track of whether the music is paused
  var isPaused = false.obs;
  // storing the index of the current track being played
  var currentTrackIndex = 0.obs;
  // tracking the current position within the track
  var position = Duration().obs;
  // storing the total duration of the track
  var duration = Duration().obs;
  // checking if the badge has been shown
  var badgeShown = false.obs;

  // Initializing the AudioPlayer to handle music fully
  AudioPlayer audioPlayer = AudioPlayer();

  // initializing itunesController
  // ItunesController itunesController;
  late ItunesController itunesController;

  @override
  void onInit() {
    super.onInit();
    itunesController = Get.find<ItunesController>();
    _loadFavorites();

    // Loading the initial status of the badge from shared preferences
    _loadBadgeShownStatus();

    // Listening for changes in the track's duration and updating accordingly
    audioPlayer.onDurationChanged.listen((d) => updateDuration(d));
    // Listening for changes in the track's position and updating the position variable
    audioPlayer.onAudioPositionChanged.listen((p) => updatePosition(p));

    // handling the event when a track finishes playing
    audioPlayer.onPlayerCompletion.listen((_) => onComplete());
  }

  // Loading whether the badge has been shown from shared preferences
  Future<void> _loadBadgeShownStatus() async {
    final prefs = await SharedPreferences.getInstance(); //shared preferences is used to store data on local storage on device
    // Updating the observable with the stored value, defaulting to false if not found
    badgeShown.value = prefs.getBool('badgeShown') ?? false;
  }

  // Saving the badge shown status into shared preferences
  Future<void> _saveBadgeShownStatus(bool shown) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('badgeShown', shown);
  }

  // Updating both the observable and the stored badge shown status
  void setBadgeShown(bool shown) {
    badgeShown.value = shown;
    _saveBadgeShownStatus(shown);
  }

  // Handling play and pause actions based on the current state
  void playPause(String url) {
    if (isPlaying.value && !isPaused.value) {
      // Pausing the music if it's currently playing
      audioPlayer.pause();
      isPaused.value = true;
    } else if (isPaused.value) {
      // Resuming the music if it's paused
      audioPlayer.resume();
      isPaused.value = false;
    } else {
      // Starting to play the track if it's not playing
      audioPlayer.play(url);
      isPlaying.value = true;
      isPaused.value = false;
    }
  }

  // Stopping the music and resetting the play/pause states
  void stop() {
    audioPlayer.stop();
    isPlaying.value = false;
    isPaused.value = false;
  }

  // Playing the next track in the search results
  void playNext() {
    if (itunesController.searchResults.isNotEmpty &&
        currentTrackIndex.value < itunesController.searchResults.length - 1) {
      // moving to the next track in the list
      currentTrackIndex.value++;
      // playing the next track
      playTrack(itunesController.searchResults[currentTrackIndex.value]);
    }
  }

  // Playing the previous track in the search results
  void playPrevious() {
    if (itunesController.searchResults.isNotEmpty &&
        currentTrackIndex.value > 0) {
      // moving to the previous track in the list
      currentTrackIndex.value--;
      // playing the previous track
      playTrack(itunesController.searchResults[currentTrackIndex.value]);
    }
  }

  // Stopping any current playback and starting the selected track
  void playTrack(ItunesModel track) {
    stop(); // ensuring any playing track is stopped before starting a new one
    playPause(track.previewUrl); // playing the selected track
  }

  // Updating the current position of the track
  void updatePosition(Duration position) {
    this.position.value = position;
  }

  // Updating the total duration of the track
  void updateDuration(Duration duration) {
    this.duration.value = duration;
  }

  // Resetting the play/pause states when the track completes
  void onComplete() {
    isPlaying.value = false;
    isPaused.value = false;
  }

  RxList<String> favoriteTracks = <String>[].obs;

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    favoriteTracks.value = favorites;
  }

  bool isFavorite(String trackName) {
    return favoriteTracks.contains(trackName);
  }

  Future<void> toggleFavorite(String trackName) async {
    if (isFavorite(trackName)) {
      favoriteTracks.remove(trackName);
    } else {
      favoriteTracks.add(trackName);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favoriteTracks.toList());
  }

  // Future<void> _loadFavorites() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   favoriteTracks.value = prefs.getStringList('favorites') ?? [];
  // }

  Future<void> addFavorite(String trackName) async {
    final prefs = await SharedPreferences.getInstance();
    if (!favoriteTracks.contains(trackName)) {
      favoriteTracks.add(trackName);
      await prefs.setStringList('favorites', favoriteTracks);
    }
  }

  Future<void> removeFavorite(String trackName) async {
    final prefs = await SharedPreferences.getInstance();
    favoriteTracks.remove(trackName);
    await prefs.setStringList('favorites', favoriteTracks);
  }
}

