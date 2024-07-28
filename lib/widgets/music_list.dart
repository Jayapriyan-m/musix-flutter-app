import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/models/itune_model.dart';
import 'package:musix/widgets/loading_animation.dart';

class MusicPlayerWidget extends StatelessWidget {
  final ItunesModel track;
  MusicPlayerWidget({required this.track});

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

    return InkWell(
      onTap: () {
        musicController.audioPlayer.stop();
        musicController.isPlaying = false;
        musicController.isPaused = false;
        showMusicPlayerDialog(context,track);
        },
      child: ListTile(
        leading: Image.network(track.artworkUrl100),
        title: Text(track.trackName),
        subtitle: Text(track.artistName),
        trailing: Icon(Icons.play_arrow),
      ),
    );
  }
}
