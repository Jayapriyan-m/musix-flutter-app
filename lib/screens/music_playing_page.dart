
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/models/itune_model.dart';
import 'package:musix/widgets/loading_animation.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MusicController musicController = Get.find<MusicController>();
    final ItunesController itunesController = Get.find<ItunesController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Obx(() {
          final searchResults = itunesController.searchResults;
          final currentIndex = musicController.currentTrackIndex.value;
          final track = searchResults.isNotEmpty && currentIndex < searchResults.length
              ? searchResults[currentIndex]
              : (searchResults.isNotEmpty ? searchResults.last : ItunesModel(
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
              Text(
                track.trackName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Image.network(track.artworkUrl100),
              SizedBox(height: 20),
              !musicController.isPlaying.value || musicController.isPaused.value
                  ? Padding(
                padding: EdgeInsets.symmetric(vertical: 17),
                child: track.previewUrl != 'null'
                    ? Text('Click play to preview')
                    : Text("Music not available :("),
              )
                  : MusicLoading(),
              SizedBox(height: 20),
              Column(
                children: [
                  Slider(
                    value: musicController.position.value.inSeconds.toDouble(),
                    min: 0,
                    max: musicController.duration.value.inSeconds.toDouble(),
                    onChanged: (value) {
                      final position = Duration(seconds: value.toInt());
                      musicController.audioPlayer.seek(position);
                    },
                  ),
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
              ),
            ],
          );
        }),
      ),
    );
  }
}

