import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MusicLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centering the content
        children: [
          SpinKitWave(
            color: Colors.redAccent, // Color of the loading spinner
            size: 50.0, // Size of the loading spinner
          ),
          // SizedBox(height: 20), // Space between the spinner and the text
          // Text(
          //   'MusiX', // Text to display
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }
}
