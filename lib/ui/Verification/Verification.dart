import 'package:eezi_connect/ui/Verification/components/Logo/LogoComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 360.w,
          height: 640.h,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 360.h,
                  width: double.infinity,
                  color: COLOR_CONNECT_1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 45.h, left: 20.w),
                        child: Icon(
                          Icons.west,
                          color: COLOR_WHITE,
                          size: 24.w,
                        ),
                      ),
                      LogoComponent(),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 83.68.h),
                          child: Text(
                            'Enter the 6-digit code sent to your number',
                            style: TextStyle(
                              color: COLOR_WHITE,
                              fontSize: 12.nsp,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 10.h),
                          child: Text(
                            '+62-818-1080-87',
                            style: TextStyle(
                              color: COLOR_WHITE,
                              fontSize: 18.nsp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 360.h,
                left: 0,
                right: 0,
                child: Container(
                  height: 280.h,
                  width: double.infinity,
                  color: COLOR_WHITE,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 67.h),
                        width: 230.w,
                        child: PinInputTextFormField(
                          decoration: UnderlineDecoration(
                            colorBuilder: PinListenColorBuilder(
                              COLOR_PRIMARY_1,
                              COLOR_GRAY,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 67.h),
                        child: Text(
                          'Did not receive it?',
                          style: TextStyle(
                            color: COLOR_PRIMARY_1,
                            fontSize: 12.nsp,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          'Request a new code in (00:30)',
                          style: TextStyle(
                            color: COLOR_PRIMARY_1,
                            fontSize: 12.nsp,
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