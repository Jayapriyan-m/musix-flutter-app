// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/widgets/app_bar_widget.dart';
import 'package:musix/widgets/bottomBar.dart';
import 'package:musix/widgets/drawer.dart';
import 'package:musix/widgets/dropdown.dart';
import 'package:musix/widgets/initial_grid_view.dart';
import 'package:musix/widgets/loading_animation.dart';
import 'package:musix/widgets/music_list.dart';
import 'package:musix/widgets/search_field.dart';

class SeacrhResultScreen extends StatelessWidget {
  // Initializing the ItunesController and injecting it into the widget tree
  final ItunesController controller =
  Get.put(ItunesController(itunesService: ItunesService()));

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size; // Getting the screen size

    return PopScope(
      canPop: false,
      onPopInvoked: (bool shouldPop) async {
        // Clearing the search field and performing a new search when the back button is pressed
        controller.searchFieldController.clear();
        await controller.search(true);
      },
      child: Scaffold(
        appBar: AppBarWidget(), // Custom app bar widget
        drawer: MusixDrawer(), // Custom drawer widget
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchField(), // Custom search field widget
              SizedBox(height: 10.h),
              Obx(() {
                // Building the filter row dynamically based on the controller's state
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Toggling the filter and clearing it if disabled
                        if (controller.isFilter.value) {
                          controller.isFilter.value = false;
                          controller.clearFilter();
                        } else {
                          controller.isFilter.value = true;
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Container(
                          width: 70.w,
                          padding: EdgeInsets.only(
                              left: 6.w, top: 6.h, bottom: 6.h, right: 3.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: controller.isFilter.value
                                ? Color.fromARGB(255, 252, 32, 65)
                                : Color.fromARGB(255, 48, 48, 48),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_list_alt,
                                size: 18.sp,
                              ),
                              SizedBox(width: 4.5.w),
                              Text(
                                'Filter',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    // Displaying the dropdown filters if filtering is enabled
                    controller.isFilter.value
                        ? Row(
                      children: [
                        Obx(() {
                          // Media Type dropdown filter
                          return Dropdown(
                            selectedValue: controller.mediaType.value,
                            items: controller.mediaTypeList,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.updateMediaType(newValue);
                              }
                            },
                            title: "Media Type",
                            firstValue: "all",
                          );
                        }),
                        Obx(() {
                          // Result Order dropdown filter
                          return Dropdown(
                            selectedValue: controller.resultOrder.value,
                            items: controller.resultOrderList,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.updateResultOrder(newValue);
                              }
                            },
                            title: "Result Order",
                            firstValue: "top hits",
                          );
                        })
                      ],
                    )
                        : Container()
                  ],
                );
              }),
              SizedBox(height: 10.h),
              // Displaying the search result description
              Obx(
                    () => Padding(
                  padding: EdgeInsets.only(
                      top: 5.h, left: 15.w, bottom: 20.w, right: 15.w),
                  child: Text(
                    "${capitalize(controller.resultOrder.value)} of ${capitalize(controller.searchFieldController.text)}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Showing the search results or loading animation based on the state
              Obx(() {
                if (controller.isLoading.value) {
                  return Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.15),
                    child: Center(child: MusicLoading()), // Loading animation
                  );
                } else if (controller.noResultsFound.value) {
                  return Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.25),
                      child: Center(child: Text('No results found.'))); // No results message
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.searchResults.length,
                      itemBuilder: (context, index) {
                        final item = controller.searchResults[index];
                        return MusicPlayerWidget(
                          track: item,
                          currentIndex: index,
                        ); // Widget for displaying each track in the search results
                      },
                    ),
                  );
                }
              })
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(), // Custom bottom navigation bar
      ),
    );
  }
}

// Function to capitalize the first letter of each word in a string
String capitalize(String text) {
  if (text.isEmpty) return text;
  return text.split(' ').map((word) {
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}
