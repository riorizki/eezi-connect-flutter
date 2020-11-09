import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
    this.imageName,
    this.mt = 0.0,
    this.mb = 0.0,
    this.mr = 0.0,
    this.ml = 0.0,
  }) : super(key: key);

  final String imageName;
  final double mt, mb, mr, ml;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: mt.h,
        bottom: mb.h,
        right: mr.w,
        left: ml.w,
      ),
      width: 100.h,
      height: 100.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/$imageName'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
