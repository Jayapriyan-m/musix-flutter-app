import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/screens/home_page.dart';
import 'package:musix/screens/splash_screen.dart';

void main() {
  runApp(Musix()); // Start the Musix app by running the Musix widget
}

class Musix extends StatelessWidget {
  // Initializing ItunesController and injecting ItunesService dependency
  final ItunesController controller = Get.put(ItunesController(itunesService: ItunesService()));

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // Design size for screen scaling
      minTextAdapt: true, // Adjusting text size
      splitScreenMode: true, // It enable split-screen mode
      builder: (context, child) {
        return Obx(() {
          return GetMaterialApp(
            title: 'Musix', // App title (Name of the App :) )
            theme: ThemeData(
              useMaterial3: false,// Using Material Design 2
              brightness: Brightness.light, // light mode is not fully developed
              primarySwatch: Colors.red,
              textTheme: TextTheme(
                bodyLarge: TextStyle(color: Colors.black),
                bodyMedium: TextStyle(color: Colors.grey[800]), 
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: false, // Using Material Design 2
              brightness: Brightness.dark, // Dark theme
              primarySwatch: Colors.red, // Primary color for the app in dark mode
            ),
            themeMode: controller.theme, // Use theme mode from controller
            debugShowCheckedModeBanner: false, // Disabling debug banner
            home: SplashScreen(), // Initial screen of the app
          );
        });
      },
    );
  }
}
