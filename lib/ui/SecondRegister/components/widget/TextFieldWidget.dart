import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key key,
    this.hint,
    this.controller,
    this.isEnabled = true,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 40.h,
      child: TextField(
        enabled: isEnabled,
        controller: controller,
        style: TextStyle(
          color: COLOR_PRIMARY_1,
          fontSize: 12.nsp,
        ),
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          suffixIcon: isEnabled == true ? null : Icon(Icons.lock_outline),
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
          disabledBorder: OutlineInputBorder(
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
