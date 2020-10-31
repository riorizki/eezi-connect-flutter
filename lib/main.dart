import 'package:eezi_connect/ui/FirstRegister/FirstRegister.dart';
import 'package:eezi_connect/ui/Home/Home.dart';
import 'package:eezi_connect/ui/SecondRegister/SecondRegister.dart';
import 'package:eezi_connect/ui/Verification/Verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Epilogue',
      ),
      home: InitialScreen(),
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
