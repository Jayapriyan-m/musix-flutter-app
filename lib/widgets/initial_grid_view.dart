import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/models/itune_model.dart';
import 'package:musix/screens/music_playing_page.dart';
import 'package:musix/widgets/loading_animation.dart';

class GridItem extends StatelessWidget {
  final ItunesModel track; // created track model
  final int currentIndex; // current index of the tracked tapped by the user

  GridItem({required this.track, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final MusicController musicController = Get.put(MusicController()); // Initializing MusicController

    return GestureDetector(
      onTap: () {
        // setting the current track index and playing the selected track
        musicController.currentTrackIndex.value = currentIndex;
        musicController.playTrack(track);

        // Showing the MusicPlayerPage as a bottom sheet
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return MusicPlayerPage();
          },
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                track.artworkUrl100, // URL for the track artwork
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover, // it covers the full card
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent], // Gradient from black to transparent
                  begin: Alignment.bottomCenter, // from bottom centre
                  end: Alignment.topCenter, // to top centre
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(), // pushing the content to the bottom of the card
                  Container(
                    width: 120.w,
                    child: Text(
                      track.trackName, // Displaying the track name
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 12, // Font size
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis, // Ellipsis for text overflow -> it shows .... when over flows
                      ),
                    ),
                  ),
                  SizedBox(height: 4), // Space between track name and price
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Text(
                      "\$ ${track.trackPrice}", // Displaying the track price
                      style: TextStyle(
                        color: Colors.black, // Text color
                        fontSize: 10, // Font size
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
