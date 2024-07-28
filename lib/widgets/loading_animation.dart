import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MusicLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitWave(
            color: Colors.redAccent,
            size: 50.0,
          ),
          // SizedBox(height: 20),
          // Text(
          //   'MusiX',
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
