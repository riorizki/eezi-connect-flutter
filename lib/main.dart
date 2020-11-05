import 'package:eezi_connect/ui/FirstRegister/FirstRegister.dart';
import 'package:eezi_connect/ui/FirstRegister/FirstRegisterController.dart';
import 'package:eezi_connect/ui/Home/Home.dart';
import 'package:eezi_connect/ui/Login/Login.dart';
import 'package:eezi_connect/ui/SplashScreen/SplashScreen.dart';
import 'package:eezi_connect/ui/Verification/Verification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Epilogue',
      ),
      home: InitialScreen(),
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    );
  }
}

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 640),
      allowFontScaling: false,
    );

    return HomeScreen();
  }
}
