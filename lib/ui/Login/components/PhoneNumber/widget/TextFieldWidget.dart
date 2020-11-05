import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key key,
    @required this.textController,
  }) : super(key: key);
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      height: 31.h,
      child: TextField(
        controller: textController,
        style: TextStyle(
          color: COLOR_WHITE,
          fontSize: 12.nsp,
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          isDense: true,
          hintText: '818-1080-87',
          hintStyle: TextStyle(
            color: COLOR_WHITE.withOpacity(0.1),
            fontSize: 12.nsp,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: COLOR_WHITE.withOpacity(0.1)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: COLOR_WHITE.withOpacity(0.1)),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: COLOR_WHITE.withOpacity(0.1)),
          ),
        ),
      ),
    );
  }
}
