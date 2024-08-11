// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/widgets/all_snack_bars.dart';
import 'package:musix/widgets/countries_popup.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  // Initializing the ItunesController
  final ItunesController controller = Get.put(ItunesController(itunesService: ItunesService()));

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(bottom: 3.h, right: 20.w),
        child: Image.asset(
          "assets/applogomain.png", // Logo for the AppBar
          width: screenSize.width * 0.40,
          height: 38.h,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent, // Transparent background
      elevation: 0, // No shadow
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEE353A), // Solid color background
          // gradient: LinearGradient(
          //   colors: [Colors.red, Colors.redAccent.shade400],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(5.0), // Rounded bottom corners
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the right
            children: [
              Obx(() {
                return IconButton(
                  icon: Icon(
                    controller.isDarkMode.value
                        ? Icons.nightlight_round // Dark mode icon
                        : Icons.wb_sunny, // Light mode icon
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Show snackbar indicating that theme switching is under development
                    underDevelopmentSnackBar();
                  },
                );
              }),
              IconButton(
                onPressed: () {
                  // Show a dialog popup to select a country
                  Get.dialog(SelectCountry());
                },
                icon: Icon(
                  Icons.language,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
