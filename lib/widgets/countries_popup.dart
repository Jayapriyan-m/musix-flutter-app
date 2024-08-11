// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itunes_country_code_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/widgets/dropdown_country.dart';

class SelectCountry extends StatelessWidget {
  const SelectCountry({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final ItunesController controller = Get.find<ItunesController>();

    return AlertDialog(
      title: Text(
        'Region',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFFEE353A),
        ),
      ),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: screenSize.height * 0.3, // height of the content
          ),
          child: Obx(() => DropdownCountry<String>(
            hideIcon: false, // Showing the dropdown icon
            child: Text('Select Country', style: TextStyle(color: Colors.white),), // Label for the dropdown
            items: controller.countries
                .map((country) {
              // Mapping each country to a DropdownItem
              // curCountry = country.code;
              return DropdownItem<String>(
                value: country.code,
                child: Text(
                  country.name,
                  style: TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            onChange: (country) {
              // Updating the selected country in the controller
              // curCountry = CountryService.countryList.keys.firstWhere(
              //         (k) => CountryService.countryList[k] == country);
              // print("curr-->$curCountry");
              controller.updateCountry(
                  country); // Setting the selected country
              Get.back(); // Closing the dialog
            },
            selectedValue: controller.selectedCountry.value, // Setting the currently selected country
            dropdownButtonStyle: DropdownButtonStyle(
              width: screenSize.width / 3.7, // width of the dropdown button
              height: 30.h, //  height of the dropdown button
            ),
            dropdownStyle: DropdownStyle(
              padding: EdgeInsets.all(2),
              constraints: BoxConstraints(
                maxHeight: 140.h, // maximum height of the dropdown menu
              ),
            ), // Hiding the search box inside the dropdown
          )),
        ),
      ),
    );
  }
}
