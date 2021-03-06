import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key key,
    this.hint,
    this.controller,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 40.h,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        controller: controller,
        style: TextStyle(
          color: COLOR_PRIMARY_1,
          fontSize: 12.nsp,
        ),
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.all(10.0),
          isDense: true,
          hintText: '$hint',
          hintStyle: TextStyle(
            color: COLOR_GRAY,
            fontSize: 12.nsp,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: COLOR_GRAY,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: COLOR_GRAY,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
