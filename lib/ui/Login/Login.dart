import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/ui/Login/LoginController.dart';
import 'package:eezi_connect/ui/Login/components/Logo/LogoComponent.dart';
import 'package:eezi_connect/ui/Login/components/PhoneNumber/PhoneNumberComponent.dart';
import 'package:eezi_connect/ui/Login/components/Title/TitleComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'components/Subtitle/SubtitleComponent.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: 470.h,
                  width: 1.sw,
                  color: COLOR_CONNECT_1,
                  child: Column(
                    children: [
                      // Logo
                      LogoComponent(),
                      // Welcome to EEZI Connect!
                      TitleComponent(),
                      // Enter your mobile number to continue
                      SubtitleComponent(),
                      // Phone Number
                      PhoneNumberComponent(
                        onTap: () {
                          print('login');
                          controller.register();
                        },
                        textController: controller.phoneController,
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Content
              Positioned(
                bottom: 0.h,
                child: Container(
                  height: 170.h,
                  width: 1.sw,
                  color: COLOR_WHITE,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 36.h, bottom: 22.h),
                          child: Text(
                            'Or continue using your social media account',
                            style: TextStyle(
                              fontSize: 12.nsp,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 105.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('Facebook Login Pressed');
                                  // controller.loginFacebook();
                                  controller.showSuccessBanner('In Progress');
                                },
                                child: Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/facebook.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('Google Login Pressed');
                                  controller.loginGoogle();
                                  // controller.signOutGoogle();
                                },
                                child: Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/google.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 105.w,
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
        ),
      ),
    );
  }
}
