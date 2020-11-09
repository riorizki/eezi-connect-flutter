import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardIconWidget extends StatelessWidget {
  const CardIconWidget({
    Key key,
    this.mt = 0.0,
    this.mb = 0.0,
    this.mr = 20.0,
    this.ml = 20.0,
    @required this.iconName,
    @required this.title,
  }) : super(key: key);

  final double mt, mb, mr, ml;
  final IconData iconName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: mt.h,
            bottom: mb.h,
            right: mr.w,
            left: ml.w,
          ),
          width: 100.h,
          height: 100.h,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Icon(
              iconName,
              size: 43.w,
            ),
          ),
        ),
        Container(
          child: Text(
            '$title',
            style: TextStyle(
              fontSize: 18.nsp,
              color: COLOR_PRIMARY_1,
            ),
          ),
        ),
      ],
    );
  }
}
