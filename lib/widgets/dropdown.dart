import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final String title;
  final String firstValue;

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
            width: (selectedValue != firstValue) ? 110.w : 84.w,
            padding: EdgeInsets.only(left: 9.w,top: 6.h,bottom: 6.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (selectedValue != firstValue) ? Color.fromARGB(255,252,32,65) : Color.fromARGB(255,48,48,48,),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
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
                    : Container()
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                  color: (selectedValue != firstValue)
                      ? Color.fromARGB(255,252,32,65)
                      : Colors.grey.shade300,
                  width: (selectedValue != firstValue) ? 2.5 : 1.5),
              boxShadow: [
                BoxShadow(
                  color: (selectedValue != firstValue)
                      ? Color.fromARGB(255,252,32,65).withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                onChanged: onChanged,
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value.toLowerCase(),
                    child: Text(
                      value,
                      style: TextStyle(
                          color:
                              (selectedValue != firstValue && selectedValue == value)
                                  ? Color.fromARGB(255,252,32,65)
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
                // isExpanded: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
