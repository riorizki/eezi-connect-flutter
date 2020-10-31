import 'package:eezi_connect/ui/SecondRegister/components/widget/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eezi_connect/config/ColorConfig.dart';

class SecondRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90.h,
              width: double.infinity,
              color: COLOR_CONNECT_1,
              child: Container(
                margin: EdgeInsets.only(top: 25.h),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.w, right: 101.w),
                      child: Icon(
                        Icons.west,
                        color: COLOR_WHITE,
                        size: 24.w,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Hi, Friend',
                        style: TextStyle(
                          color: COLOR_WHITE,
                          fontSize: 16.nsp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 90.h,
            left: 0,
            right: 0,
            child: Container(
              height: 550.h,
              width: double.infinity,
              color: COLOR_WHITE,
              child: Container(
                margin: EdgeInsets.only(top: 20.h),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: Row(
                        children: [
                          Container(
                            width: 72.w,
                            height: 75.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: COLOR_GRAY),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.add_a_photo,
                              color: COLOR_GRAY,
                              size: 24.w,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 18.w,
                            ),
                            child: Text(
                              'Select your profile picture',
                              style: TextStyle(
                                color: COLOR_PRIMARY_1,
                                fontSize: 12.nsp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFieldComponent(
                      mt: 15,
                      title: 'Full Name',
                      hint: 'ex. Joe Doe',
                    ),
                    TextFieldComponent(
                      mt: 15,
                      title: 'Phone Number',
                      hint: '+62 818 1080 87',
                    ),
                    TextFieldComponent(
                      mt: 15,
                      title: 'Email',
                      hint: 'joedhoe@mail.com',
                    ),
                    TextFieldComponent(
                      mt: 15,
                      title: 'Address',
                      hint: 'ex. Jl. Bandoeng No. 11',
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 55.h, right: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: COLOR_PRIMARY_1,
                                fontSize: 12.nsp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Container(
                            width: 86.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: COLOR_ACCENT,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: COLOR_PRIMARY_1,
                                fontSize: 12.nsp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    Key key,
    this.title,
    this.hint,
    this.mt = 0.0,
    this.mr = 0.0,
    this.mb = 0.0,
    this.ml = 0.0,
  }) : super(key: key);

  final String title;
  final String hint;
  final double mt, mr, mb, ml;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mt.h, right: mr.w, bottom: mb.h, left: ml.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.h),
            child: Text(
              '$title',
              style: TextStyle(
                color: COLOR_PRIMARY_1,
                fontSize: 12.nsp,
              ),
            ),
          ),
          TextFieldWidget(hint: hint),
        ],
      ),
    );
  }
}
