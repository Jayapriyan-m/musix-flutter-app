import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/splash_view_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  // Initializing the SplashController
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size; // Getting the screen size

    return Scaffold(
      body: Image.asset(
        'assets/splashMain.png',
        height: screenSize.height, // Setting the image height to match the screen height
        width: screenSize.width,   // Setting the image width to match the screen width
        fit: BoxFit.fill,          // Ensuring the image fills the entire screen
      ),
    );
  }
}
