import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/ui/Verification/VerificationViewModel.dart';
import 'package:eezi_connect/ui/Verification/components/Logo/LogoComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:stacked/stacked.dart';

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerificationViewModel>.reactive(
      onModelReady: (model) => model.onInit(),
      viewModelBuilder: () => VerificationViewModel(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: LoadingOverlay(
          isLoading: model.isBusy,
          child: SingleChildScrollView(
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
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 45.h, left: 20.w),
                              child: Icon(
                                Icons.west,
                                color: COLOR_WHITE,
                                size: 24.w,
                              ),
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
                                '${model.phoneNumber}',
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
                            child: PinInputTextField(
                              onSubmit: (pin) {
                                debugPrint('submit pin:$pin');
                                model.verification();
                              },
                              controller: model.textController,
                              decoration: UnderlineDecoration(
                                colorBuilder: PinListenColorBuilder(
                                  COLOR_PRIMARY_1,
                                  COLOR_GRAY,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 47.h),
                            child: FlatButton(
                              onPressed: model.buttonEnable
                                  ? () {
                                      //request new verification code
                                      model.setTimer();
                                    }
                                  : () {
                                      model.showErrorBanner(
                                          'Wait ${model.timerTick} second to request new code!');
                                    },
                              child: Text(
                                'Did not receive it?',
                                style: TextStyle(
                                  color: COLOR_PRIMARY_1,
                                  fontSize: 12.nsp,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Text(
                              'Request a new code in (00:${model.timerTick})',
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
        ),
      ),
    );
  }
}
