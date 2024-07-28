// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/widgets/app_bar_widget.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(),
            SizedBox(height: 10.h),
            Obx(() {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // controller.isFilter
                      //     ? controller.enableFilter(false)
                      //     : controller.enableFilter(true);
                      if(controller.isFilter == true){
                        controller.isFilter.value = false;
                        controller.clearFilter();
                      }else{
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
                            color: controller.isFilter == true
                                ? Color.fromARGB(255, 252, 32, 65)
                                : Color.fromARGB(255,48, 48,48,),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_list_alt,
                                size: 18.sp,
                              ),
                              SizedBox(
                                width: 4.5.w,
                              ),
                              Text(
                                'Filter',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  controller.isFilter == true
                      ? Row(
                        children: [
                          Obx(() {
                              return Dropdown(
                                selectedValue: controller.mediaType.value,
                                items: controller.mediaTypeList,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    controller.updateMediaType(newValue);
                                    // controller.search();
                                  }
                                },
                                title: "Media Type",
                                firstValue: "all",
                              );
                            }),
                          Obx(() {
                            return Dropdown(
                              selectedValue: controller.resultOrder.value,
                              items: controller.resultOrderList,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.updateResultOrder(newValue);
                                  // controller.search();
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
            SizedBox(
              height: 10.h,
            ),
            controller.searchFieldController.text.isNotEmpty
            ? Container()
            : Padding(
              padding: EdgeInsets.only(top: 5.h,left: 15.w,bottom:20.w,right: 15.w ),
              child: Text("Top Tracks of ${controller.currentInitTerm}",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ),
            controller.searchFieldController.text.isNotEmpty
            ? Obx(() {
              if (controller.isLoading.value) {
                return Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.15),
                  child: Center(child: MusicLoading()),
                );
              } else if (controller.noResultsFound.value) {
                return Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.25),
                    child: Center(child: Text('No results found.')));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      final item = controller.searchResults[index];
                      if (kDebugMode) {
                        print("check music track - name ${item.trackName} -> ${item.previewUrl}");
                      }
                      return MusicPlayerWidget(track: item);
                    },
                  ),
                );
              }
            })
            : Obx(() {
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
                      childAspectRatio: 1.5,
                    ),
                    itemCount: controller.searchResults.length ,
                    itemBuilder: (context, index) {
                      final item = controller.searchResults[index];
                      if (kDebugMode) {
                        print("check music track - name ${item.trackName} -> ${item.previewUrl}");
                      }
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
