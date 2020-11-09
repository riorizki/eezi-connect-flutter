import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/ui/Home/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({
    Key key,
    this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 90.h,
        color: COLOR_CONNECT_1,
        child: Container(
          margin: EdgeInsets.only(
            top: 25.h,
            left: 19.w,
            right: 19.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  child: Icon(
                    Icons.west,
                    color: COLOR_WHITE,
                    size: 24.w,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Hi, $username',
                  style: TextStyle(
                    fontSize: 16.nsp,
                    color: COLOR_WHITE,
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
