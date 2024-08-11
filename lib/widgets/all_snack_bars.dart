import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Function to show a Snackbar indicating that theme switching is under development.
void underDevelopmentSnackBar() {
  Get.snackbar(
    "Switching Themes is under Development",
    "Coming Soon...",
    backgroundColor: Colors.grey[900],       // Background color of the Snackbar
    colorText: Colors.white,                 // Text color
    snackPosition: SnackPosition.BOTTOM,     // Position of the Snackbar on the screen
    margin: EdgeInsets.all(10),              // Margin around the Snackbar
    borderRadius: 8,                         // Border radius for rounded corners
    icon: Icon(
      Icons.nightlight_round,
      color: Colors.yellow,
    ),
    shouldIconPulse: true,                   // Pulse animation for the icon
    duration: Duration(seconds: 3),          // How long the Snackbar is visible
    snackStyle: SnackStyle.FLOATING,         // Snackbar style (floating above other UI elements)
  );
}

/// Function to show a Snackbar indicating that there is no internet connection.
void noInternetSnackbar() {
  Get.snackbar(
    'No Internet',
    'Please check your connection and try again.',
    backgroundColor: Colors.red[800],
    colorText: Colors.white,                 // Text color
    snackPosition: SnackPosition.BOTTOM,     // Position of the Snackbar on the screen
    margin: EdgeInsets.all(10),              // Margin around the Snackbar
    borderRadius: 8,
    icon: Icon(
      Icons.wifi_off,
      color: Colors.white,
    ),
    shouldIconPulse: true,                   // Pulse animation for the icon
    duration: Duration(seconds: 3),          // How long the Snackbar is visible
    snackStyle: SnackStyle.FLOATING,         // Snackbar style (floating above other UI elements)
  );
}
