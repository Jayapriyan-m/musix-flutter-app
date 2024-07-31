import 'package:flutter/material.dart';
import 'package:get/get.dart';

void underDevelopmentSnackBar(){
  Get.snackbar(
    "Switching Themes is under Development",
    "Coming Soon...",
    backgroundColor: Colors.grey[900],
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(10),
    borderRadius: 8,
    icon: Icon(
      Icons.nightlight_round,
      color: Colors.yellow,
    ),
    shouldIconPulse: true,
    duration: Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
  );
}

void noInternetSnackbar() {
  Get.snackbar(
    'No Internet',
    'Please check your connection and try again.',
    backgroundColor: Colors.red[800],  // Red background for error
    colorText: Colors.white,           // White text color
    snackPosition: SnackPosition.BOTTOM, // Position at the bottom
    margin: EdgeInsets.all(10),          // Margins around the snackbar
    borderRadius: 8,                     // Rounded corners
    icon: Icon(
      Icons.wifi_off,                    // WiFi off icon
      color: Colors.white,               // White icon color
    ),
    shouldIconPulse: true,               // Pulsing icon animation
    duration: Duration(seconds: 3),      // Snackbar duration
    snackStyle: SnackStyle.FLOATING,     // Floating snackbar style
  );
}