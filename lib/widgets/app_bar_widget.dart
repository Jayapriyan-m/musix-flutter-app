// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/widgets/all_snack_bars.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final ItunesController controller =
      Get.put(ItunesController(itunesService: ItunesService()));

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return AppBar(
      title:
          // Text(
          //   'MusiX',
          //   style: TextStyle(
          //     fontSize: 24.0,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.white,
          //   ),
          // ),
          Padding(
        padding: EdgeInsets.only(bottom: 3.h, right: 20.w),
        child: Image.asset(
          "assets/applogomain.png",
          width: screenSize.width * 0.40,
          height: 38.h,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEE353A),
          // gradient: LinearGradient(
          //   colors: [Colors.red, Colors.redAccent.shade400],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(5.0),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // IconButton(
              //   icon: const Icon(Icons.menu, color: Colors.white),
              //   onPressed: () {
              //   },
              // ),
              Obx(() {
                return IconButton(
                  icon: Icon(
                    controller.isDarkMode.value
                        ? Icons.nightlight_round // Icon for dark mode
                        : Icons.wb_sunny, // Icon for light mode
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // controller.toggleTheme();
                    underDevelopmentSnackBar();
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
