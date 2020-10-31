import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoComponent extends StatelessWidget {
  const LogoComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 108.w,
        height: 52.32.h,
        margin: EdgeInsets.only(
          top: 53.h,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/icon_connect.png',
            ),
          ),
        ),
      ),
    );
  }
}
