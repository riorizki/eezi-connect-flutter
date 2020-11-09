import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/ui/Home/HomeViewModel.dart';
import 'package:eezi_connect/ui/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final HomeViewModel controller;

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
            top: 40.h,
            left: 19.w,
            right: 19.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              GestureDetector(
                onTap: () {
                  controller.logout();
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        child: Icon(
                          Icons.close,
                          color: COLOR_WHITE,
                          size: 24.w,
                        ),
                      ),
                      Container(
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: COLOR_WHITE,
                            fontSize: 9.nsp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 69.w,
                height: 33.43.h,
                child: Image.asset(
                  'assets/images/icon_connect.png',
                  fit: BoxFit.fill,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(ProfileScreen());
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        child: Icon(
                          Icons.person,
                          color: COLOR_WHITE,
                          size: 24.w,
                        ),
                      ),
                      Container(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            color: COLOR_WHITE,
                            fontSize: 9.nsp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
