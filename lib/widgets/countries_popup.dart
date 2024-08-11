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
    // var curCountry = 'All';
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
              maxHeight: screenSize.height * 0.3
            ),
          child: Obx(() => DropdownCountry<String>(
            hideIcon: false,
            child: Text('Select Mode',style: TextStyle(
              color: Colors.white
            ),),
            items: controller.countries
                .map((country) {
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
              // curCountry = CountryService.countryList.keys.firstWhere(
              //         (k) => CountryService.countryList[k] == country);
              // print("curr-->$curCountry");
              controller.updateCountry(
                  country);
              Get.back();
            },
            selectedValue:  controller.selectedCountry.value,
            dropdownButtonStyle: DropdownButtonStyle(
              width: screenSize.width / 3.7,
              height: 30.h,
            ),
            dropdownStyle: DropdownStyle(
              padding: EdgeInsets.all(2),
              constraints: BoxConstraints(
                maxHeight:
                140.h, // Set the maximum height for the dropdown menu
              ),
            ),// Hide the search box
          )),
        ),
      ),

    );
  }
}
