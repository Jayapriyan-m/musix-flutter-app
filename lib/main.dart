import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/screens/home_page.dart';
import 'package:musix/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Musix',
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.red,
          ),
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,

          home: SplashScreen(),
        );
      },
    );
  }
}
