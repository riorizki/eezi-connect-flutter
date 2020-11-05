import 'package:eezi_connect/ui/FirstRegister/FirstRegisterController.dart';
import 'package:eezi_connect/ui/FirstRegister/components/Logo/LogoComponent.dart';
import 'package:eezi_connect/ui/FirstRegister/components/widget/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class FirstRegisterScreen extends StatelessWidget {
  final FirstRegisterController controller = Get.put(FirstRegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 200.h,
                  width: double.infinity,
                  color: COLOR_CONNECT_1,
                  child: Column(
                    children: [
                      LogoComponent(),
                      Container(
                        margin: EdgeInsets.only(top: 43.68.h),
                        child: Text(
                          'Hi, Welcome to EEZI Connect!',
                          style: TextStyle(
                            color: COLOR_WHITE,
                            fontSize: 18.nsp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 200.h,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 440.h,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 39.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5.h),
                              child: Text(
                                'Insert Your Username',
                                style: TextStyle(
                                  color: COLOR_PRIMARY_1,
                                  fontSize: 12.nsp,
                                ),
                              ),
                            ),
                            TextFieldWidget(
                              controller: controller.textController,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 44.h),
                        child: Text(
                          'Get full access by completed your profile information.\nComplete your profile now?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: COLOR_PRIMARY_1,
                            fontSize: 12.nsp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.completeData();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 50.h),
                          width: 126.w,
                          height: 40.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: COLOR_ACCENT,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Yes, please',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.nsp,
                              color: COLOR_PRIMARY_1,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.skip();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          child: Text(
                            'Skip for now',
                            style: TextStyle(
                              fontSize: 12.nsp,
                              color: COLOR_PRIMARY_1,
                            ),
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
