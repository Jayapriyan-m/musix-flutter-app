import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';

class SearchField extends StatelessWidget {
  // Initializing ItunesController and injecting ItunesService dependency
  final ItunesController controller = Get.put(ItunesController(itunesService: ItunesService()));

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none, // No border on initial display
        ),
        filled: true, // Fill the background with color
        fillColor: Colors.grey[850],
        prefixIcon: Icon(Icons.search, color: Colors.white),
        labelText: 'Search', // Label text
        labelStyle: TextStyle(color: Colors.white),
        hintText: 'Enter Query', // Placeholder text
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
      controller: controller.searchFieldController, // Controller to manage the text field state
      onSubmitted: (value) {
        // Triggering search when user enters the query
        controller.search(false);
      },
    );
  }
}
