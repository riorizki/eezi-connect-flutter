import 'dart:async';

import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/services/StorageService.dart';
import 'package:eezi_connect/ui/Home/Home.dart';
import 'package:eezi_connect/ui/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final StorageService service = Get.put(StorageService());
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      setHome();
    });
    super.initState();
  }

  void setHome() {
    var payload = service.read('id');
    if (payload.toString().length > 5) {
      Get.off(HomeScreen());
    } else {
      Get.off(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_CONNECT_1,
      body: Center(
        child: Container(
          width: 225.w,
          height: 140.63.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/icon.png'),
            ),
          ),
        ),
      ),
    );
  }
}
