import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubtitleComponent extends StatelessWidget {
  const SubtitleComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.h,
      ),
      child: Text(
        'Enter your mobile number to continue',
        style: TextStyle(
          color: COLOR_WHITE,
          fontSize: 12.nsp,
        ),
      ),
    );
  }
}
