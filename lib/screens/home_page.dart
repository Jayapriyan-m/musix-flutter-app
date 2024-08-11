// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/widgets/app_bar_widget.dart';
import 'package:musix/widgets/bottomBar.dart';
import 'package:musix/widgets/drawer.dart';
import 'package:musix/widgets/dropdown.dart';
import 'package:musix/widgets/initial_grid_view.dart';
import 'package:musix/widgets/loading_animation.dart';
import 'package:musix/widgets/music_list.dart';
import 'package:musix/widgets/search_field.dart';

class HomeScreen extends StatelessWidget {
  // Initializing the ItunesController with the API service
  final ItunesController controller = Get.put(ItunesController(itunesService: ItunesService()));

  @override
  Widget build(BuildContext context) {
    // Getting the screen size for responsive UI adjustments
    var screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async{
        Get.find<MusicController>().stop();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBarWidget(), // Custom AppBar
        drawer: MusixDrawer(), // Custom Drawer
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchField(), // Search input field
              SizedBox(height: 10.h), // Spacing

              // Displaying the title if results are found and not loading
              Obx(() {
                print('no result val--${controller.noResultsFound.value}');
                return !controller.noResultsFound.value && !controller.isLoading.value
                    ? Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 15.w, bottom: 20.w, right: 15.w),
                  child: Text(
                    "Top Tracks of ${controller.currentInitTerm.value}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : Container();
              }),

              // Showing different UI elements based on loading and results status
              Obx(() {
                if (controller.isLoading.value) {

                  // Displaying loading animation if data is being fetched
                  return Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.15),
                    child: Center(child: MusicLoading()),
                  );

                } else if (controller.noResultsFound.value) {
                  // Showing a prompt if no results are found
                  return Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.25),
                    child: Center(child: Text('Search any Music, Artist')),
                  );

                } else {
                  // Displaying the grid of search results
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 1,
                      ),
                      itemCount: controller.searchResults.length,
                      itemBuilder: (context, index) {
                        final item = controller.searchResults[index];
                        return GridItem(track: item, currentIndex: index);
                      },
                    ),
                  );
                }
              })
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(), // Custom Bottom Navigation Bar
      ),
    );
  }
}
