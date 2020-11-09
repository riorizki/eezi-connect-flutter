import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardBottomTitleWidget extends StatelessWidget {
  const CardBottomTitleWidget({
    Key key,
    this.mt = 0.0,
    this.mb = 0.0,
    this.mr = 0.0,
    this.ml = 0.0,
    this.imageName = 'new_systems.png',
    @required this.title,
  }) : super(key: key);

  final double mt, mb, mr, ml;
  final String imageName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: mt.h,
        bottom: mb.h,
        right: mr.w,
        left: ml.w,
      ),
      child: Column(
        children: [
          Container(
            width: 100.h,
            height: 100.h,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Container(
                width: 67.w,
                height: 65.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/$imageName',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.h),
            child: Text(
              '$title',
              style: TextStyle(
                fontSize: 12.nsp,
                color: COLOR_PRIMARY_1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
