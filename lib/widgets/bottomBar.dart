import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/screens/music_playing_page.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MusicController musicController = Get.find<MusicController>();
    final ItunesController itunesController = Get.find<ItunesController>();

    return BottomAppBar(
      height: 70.h,
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Add other bottom bar items here if needed

            Obx(() {
              final currentTrack = musicController.currentTrackIndex.value <
                  itunesController.searchResults.length
                  ? itunesController.searchResults[musicController.currentTrackIndex.value]
                  : null;

              return currentTrack != null
                  ? Align(
                alignment: Alignment.center,
                    child: BadgeLabel(
                                    label: currentTrack.trackName,
                                    icon: Icons.music_note,
                                    onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return MusicPlayerPage();
                      },
                    );
                    musicController.setBadgeShown(true);
                                    },
                                  ),
                  )
                  : SizedBox(); // Replaces Container() with SizedBox() for cleaner code
            }),
          ],
        ),
      ),
    );
  }
}

class BadgeLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  BadgeLabel({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final MusicController musicController = Get.find<MusicController>();
    var screenSize = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Obx(() {
          bool isPlaying = musicController.isPlaying.value && !musicController.isPaused.value;
          // bool isPaused = musicController.isPaused.value;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.h),
            decoration: BoxDecoration(
              color: isPlaying ? Color(0xFFEE353A) : Colors.grey[800], // Background color changes based on playing state
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: AlwaysStoppedAnimation(isPlaying ? 0.1 : 0),
                  child: Icon(
                    icon,
                    color:Colors.white, // Icon color changes based on playing state
                    size: 20,
                  ),
                ),
                SizedBox(width: 5),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis, // Ensure text is not clipped
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}