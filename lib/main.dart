import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/screens/home_page.dart';
import 'package:musix/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ItunesController controller = Get.put(ItunesController(itunesService: ItunesService()));

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(() {
          return GetMaterialApp(
            title: 'Musix',
            theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.red,
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.black), // Light theme text color
              bodyMedium: TextStyle(color: Colors.grey[800]),
              // Define other text styles here
            ),
          ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.red,
            ),
            themeMode: controller.theme,  // Use theme from controller
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        });
      },
    );
  }
}

