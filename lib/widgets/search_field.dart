import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';

class SearchField extends StatelessWidget {
  final ItunesController controller = Get.put(ItunesController(itunesService: ItunesService()));

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[850],
        prefixIcon: Icon(Icons.search, color: Colors.white),
        labelText: 'Search',
        labelStyle: TextStyle(color: Colors.white),
        hintText: 'Enter Query',
        hintStyle: TextStyle(color: Colors.grey[400]),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Color.fromARGB(255,252,32,65), width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.grey.shade700, width: 1.0), // Default border color
        ),
      ),
      controller: controller.searchFieldController,
      onSubmitted: (value) {
        controller.search();
      },
    );
  }
}
