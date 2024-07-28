import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/splash_view_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Image.asset(
        'assets/splash2.png',
        height: screenSize.height,
        width: screenSize.width,
        fit: BoxFit.fill,
      ),
    );
  }
}
