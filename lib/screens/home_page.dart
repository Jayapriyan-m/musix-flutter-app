// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/widgets/app_bar_widget.dart';
import 'package:musix/widgets/drawer.dart';
import 'package:musix/widgets/dropdown.dart';
import 'package:musix/widgets/initial_grid_view.dart';
import 'package:musix/widgets/loading_animation.dart';
import 'package:musix/widgets/music_list.dart';
import 'package:musix/widgets/search_field.dart';

class HomeScreen extends StatelessWidget {
  final ItunesController controller =
      Get.put(ItunesController(itunesService: ItunesService()));

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: MusixDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(),
            SizedBox(height: 10.h),
            Obx(() {
              print('no result val--${controller.noResultsFound.value}');
              return !controller.noResultsFound.value && !controller.isLoading.value
                  ?  Padding(
                padding: EdgeInsets.only(top: 5.h,left: 15.w,bottom:20.w,right: 15.w ),
                child: Text("Top Tracks of ${controller.currentInitTerm.value}",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              )
                  : Container();
            }),
            Obx(() {
              if (controller.isLoading.value) {
                return Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.15),
                  child: Center(child: MusicLoading()),
                );
              } else if (controller.noResultsFound.value) {
                return Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.25),
                    child: Center(child: Text('Search any Music, Artist')));
              } else {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1,
                    ),
                    itemCount: controller.searchResults.length ,
                    itemBuilder: (context, index) {
                      final item = controller.searchResults[index];
                      // if (kDebugMode) {
                      //   print("check music track - name ${item.trackName} -> ${item.previewUrl}");
                      // }
                      return GridItem(track: item);
                    },
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
