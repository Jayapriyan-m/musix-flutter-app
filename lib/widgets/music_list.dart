import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/models/itune_model.dart';
import 'package:musix/screens/music_playing_page.dart';
import 'package:musix/widgets/all_snack_bars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicPlayerWidget extends StatelessWidget {
  final ItunesModel track;
  final int currentIndex;

  MusicPlayerWidget({required this.track, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final MusicController musicController = Get.put(MusicController());

    return InkWell(
      onTap: () {
        musicController.currentTrackIndex.value = currentIndex;
        musicController.playTrack(track);

        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return MusicPlayerPage();
          },
        );
      },
      child: GetBuilder<MusicController>(
        init: MusicController(),
        builder: (controller) {
          return ListTile(
            leading: Image.network(track.artworkUrl100),
            title: Text(track.trackName),
            subtitle: Text(track.artistName),
            trailing: Obx(() {
              return IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: controller.isFavorite(track.trackName) ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  controller.isFavorite(track.trackName) ? removedFromFavorites() : addedToFavorites();
                  controller.toggleFavorite(track.trackName);
                },
              );
            }),
          );
        },
      ),
    );
  }
}
