import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/screens/music_playing_page.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the MusicController and ItunesController instances
    final MusicController musicController = Get.find<MusicController>();
    final ItunesController itunesController = Get.find<ItunesController>();

    return BottomAppBar(
      height: 70.h, // Set the height of the BottomAppBar
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space between widgets
          children: [
            // Observe changes in the MusicController and ItunesController
            Obx(() {
              // Get the current track based on the current track index
              final currentTrackIndex = musicController.currentTrackIndex.value;
              final currentTrack = currentTrackIndex < itunesController.searchResults.length
                  ? itunesController.searchResults[currentTrackIndex]
                  : null;

              // Display the BadgeLabel if there is a current track
              return currentTrack != null
                  ? BadgeLabel(
                label: currentTrack.trackName, // Pass the track name as the label
                icon: Icons.music_note, // Icon to display
                onTap: () {
                  // Show the MusicPlayerPage in a modal bottom sheet
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return MusicPlayerPage(); // Display MusicPlayerPage
                    },
                  );
                  musicController.setBadgeShown(true); // Mark the badge as shown
                },
              )
                  : SizedBox(); // Use SizedBox() if no track is available
            }),
          ],
        ),
      ),
    );
  }
}

class BadgeLabel extends StatelessWidget {
  final String label; // Text label to display
  final IconData icon; // Icon to display
  final VoidCallback onTap; // Callback for tap events

  BadgeLabel({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final MusicController musicController = Get.find<MusicController>();
    var screenSize = MediaQuery.of(context).size; // Get the screen size

    return GestureDetector(
      onTap: onTap, // Call the onTap callback when tapped
      child: Obx(() {
        // Determine if music is playing
        bool isPlaying = musicController.isPlaying.value && !musicController.isPaused.value;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.h),
          decoration: BoxDecoration(
            color: isPlaying ? Color(0xFFEE353A) : Colors.grey[800], // Background color based on playing state
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Size the row to fit its content
            mainAxisAlignment: MainAxisAlignment.center, // Center the children within the row
            children: [
              RotationTransition(
                turns: AlwaysStoppedAnimation(isPlaying ? 0.1 : 0), // Rotate icon when music is playing
                child: Icon(
                  icon,
                  color: Colors.white, // Icon color based on playing state
                  size: 20,
                ),
              ),
              SizedBox(width: 5), // Space between icon and text
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Allow horizontal scrolling
                  child: Container(
                    width: screenSize.width * 0.8, // Set the width for the text container
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis, // Ellipsis if text overflows
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
