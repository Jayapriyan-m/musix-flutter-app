import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/widgets/all_snack_bars.dart';
import 'package:musix/widgets/loading_animation.dart';

class FavoriteTracksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initializing music controller
    final MusicController musicController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Tracks'),
      ),
      body: Obx(() {
        if (musicController.favoriteTracks.isEmpty) {
          // Display this message when there are no favorite tracks
          return Center(child: Text('No favorites yet'));
        }
        return ListView.builder(
          itemCount: musicController.favoriteTracks.length,
          itemBuilder: (context, index) {
            final trackName = musicController.favoriteTracks[index];
            return ListTile(
              title: Text(trackName), // Displaying the track name from favorites list
              trailing: IconButton(
                icon: Icon(Icons.delete_rounded, color: Colors.red), // Delete icon
                onPressed: () {
                  // Calling the function to handle the removal of the favorite track
                  removedFromFavorites();
                  musicController.removeFavorite(trackName);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
