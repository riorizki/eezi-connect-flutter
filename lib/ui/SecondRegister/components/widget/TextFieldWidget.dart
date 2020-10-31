import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key key,
    this.hint,
  }) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 40.h,
      child: TextField(
        style: TextStyle(
          color: COLOR_GRAY,
          fontSize: 12.nsp,
        ),
        decoration: InputDecoration(
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
