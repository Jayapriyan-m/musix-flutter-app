import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/models/itune_model.dart';
import 'package:musix/widgets/loading_animation.dart';
import 'package:musix/widgets/music_list.dart';

class GridItem extends StatelessWidget {
  final ItunesModel track;

  GridItem({required this.track});

  @override
  Widget build(BuildContext context) {

    final MusicController musicController = Get.put(MusicController());

    void showMusicPlayerDialog(BuildContext context,track) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 16,
            child: Container(
              width: 300,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    track.trackName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15.h),
                  Image.network(track.artworkUrl100),
                  SizedBox(height: 20.h),
                  GetBuilder<MusicController>(builder:(controller){
                    return !musicController.isPlaying || musicController.isPaused
                        ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 17.h),
                      child: track.previewUrl != 'null' ? Text('Click play to preview') : Text("Music not available :("),
                    )
                        : MusicLoading();
                  } ),
                  SizedBox(height: 20.h),
                  track.previewUrl != 'null'
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GetBuilder<MusicController>(
                        builder: (controller) {
                          return IconButton(
                            icon: Icon(
                              controller.isPlaying
                                  ? (controller.isPaused
                                  ? Icons.play_arrow
                                  : Icons.pause)
                                  : Icons.play_arrow,
                            ),
                            onPressed: () {
                              controller.playPause(track.previewUrl);
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.stop),  // Custom stop icon
                        onPressed: () {
                          musicController.audioPlayer.stop();
                          musicController.isPlaying = false;
                          musicController.isPaused = false;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                      : Container()
                ],
              ),
            ),
          );
        },
      );

    }

    return  GestureDetector(
      onTap: (){
        musicController.audioPlayer.stop();
        musicController.isPlaying = false;
        musicController.isPaused = false;
        showMusicPlayerDialog(context,track);
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
                track.artworkUrl100,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Container(
                    width: 120.w,
                    child: Text(
                      track.trackName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Text(
                      "\$ ${track.trackPrice}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
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