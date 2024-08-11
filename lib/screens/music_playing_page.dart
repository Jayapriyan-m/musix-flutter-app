import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/models/itune_model.dart';
import 'package:musix/widgets/loading_animation.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Finding the necessary controllers
    final MusicController musicController = Get.find<MusicController>();
    final ItunesController itunesController = Get.find<ItunesController>();

    return Material(
      child: Container(
        // Styling the container with a black background and rounded corners
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Obx(() {
            // Getting the current track details
            final searchResults = itunesController.searchResults;
            final currentIndex = musicController.currentTrackIndex.value;
            final track = searchResults.isNotEmpty && currentIndex < searchResults.length
                ? searchResults[currentIndex]
                : (searchResults.isNotEmpty
                ? searchResults.last
                : ItunesModel(
              trackName: 'Unknown Track',
              artistName: 'Unknown Artist',
              artworkUrl100: '',
              previewUrl: '',
              releaseDate: '',
              trackPrice: 0.0,
            ));

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Adding a small drag handle at the top
                Container(
                  width: 40,
                  height: 5,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Displaying the track name
                Text(
                  track.trackName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                // Showing the album artwork or a default icon if not available
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    track.artworkUrl100,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.music_note, size: 50),
                  ),
                ),
                SizedBox(height: 20),
                // Handling the play/pause state with a message or loading animation
                track.previewUrl.isNotEmpty
                    ? !musicController.isPlaying.value || musicController.isPaused.value
                    ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 17),
                  child: Text('Click play to preview'),
                )
                    : MusicLoading()
                    : Text("Music not available :("),
                SizedBox(height: 20),
                // Showing the playback controls if the track is available
                track.previewUrl.isNotEmpty
                    ? Column(
                  children: [
                    // Adding a slider to control track position
                    Slider(
                      value: musicController.position.value.inSeconds.toDouble(),
                      min: 0,
                      max: musicController.duration.value.inSeconds.toDouble(),
                      onChanged: (value) {
                        final position = Duration(seconds: value.toInt());
                        musicController.audioPlayer.seek(position);
                      },
                    ),
                    // Displaying playback control buttons (previous, play/pause, stop, next)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.skip_previous),
                          onPressed: () => musicController.playPrevious(),
                        ),
                        IconButton(
                          icon: Icon(
                            musicController.isPlaying.value
                                ? (musicController.isPaused.value
                                ? Icons.play_arrow
                                : Icons.pause)
                                : Icons.play_arrow,
                          ),
                          onPressed: () => musicController.playPause(track.previewUrl),
                        ),
                        IconButton(
                          icon: Icon(Icons.stop),
                          onPressed: () => musicController.stop(),
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_next),
                          onPressed: () => musicController.playNext(),
                        ),
                      ],
                    ),
                  ],
                )
                    : Container(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

