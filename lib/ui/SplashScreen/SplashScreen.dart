import 'dart:async';

import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/injectable.dart';
import 'package:eezi_connect/services/AuthService.dart';
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
  final StorageService service = getIt.get<StorageService>();
  final AuthService authService = getIt.get<AuthService>();

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      // logout();
      setHome();
    });
    super.initState();
  }

  void logout() async {
    authService.signOutGoogle();
    authService.signOutFacebook();
    print("User Signed Out");
    service.remove();

    print('called');
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
