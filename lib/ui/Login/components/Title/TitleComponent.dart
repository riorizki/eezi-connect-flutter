import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleComponent extends StatelessWidget {
  const TitleComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 108.68.h,
      ),
      child: Text(
        'Welcome to EEZI Connect!',
        style: TextStyle(
          color: COLOR_WHITE,
          fontSize: 18.nsp,
        ),
      ),
    );
  }
}
