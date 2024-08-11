import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dropdown extends StatelessWidget {
  final String? selectedValue; // holds the currently selected value
  final List<String> items; // items to be displayed in the dropdown
  final ValueChanged<String?>? onChanged; // Callback for when a new item is selected
  final String title; // dropdown header
  final String firstValue; // default value

  const Dropdown({
    Key? key,
    required this.selectedValue,
    required this.items,
    this.onChanged,
    required this.title,
    required this.firstValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, top: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: (selectedValue != firstValue) ? 110.w : 84.w, // Adjusting width based on selection
            padding: EdgeInsets.only(left: 9.w, top: 6.h, bottom: 6.h), // Padding inside the container
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (selectedValue != firstValue) ? Color(0xFFEE353A) : Color.fromARGB(255, 48, 48, 48), // Changing color based on selection
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp, // adjustable font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                (selectedValue != firstValue)
                    ? Row(
                  children: [
                    SizedBox(
                      width: 4.5.w,
                    ),
                    Icon(
                      Icons.check,
                      size: 18.sp,
                    )
                  ],
                )
                    : Container() // hiding check icon if no selection
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 40.h, // height of the dropdown button
            padding: EdgeInsets.symmetric(horizontal: 10), // horizontal padding inside the dropdown button
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                  color: (selectedValue != firstValue)
                      ? Color(0xFFEE353A)
                      : Colors.grey.shade300,
                  width: (selectedValue != firstValue) ? 2.5 : 1.5),
              boxShadow: [
                BoxShadow(
                  color: (selectedValue != firstValue)
                      ? Color(0xFFEE353A).withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                  blurRadius: 8, // blur radius for the shadow
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue, // Currently selected value
                onChanged: onChanged, // Callback for when a new item is selected
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value.toLowerCase(), // Value for each item
                    child: Text(
                      value, // Displaying text for each item
                      style: TextStyle(
                          color:
                          (selectedValue != firstValue && selectedValue == value)
                              ? Color(0xFFEE353A)
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp),
                    ),
                  );
                }).toList(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                dropdownColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
