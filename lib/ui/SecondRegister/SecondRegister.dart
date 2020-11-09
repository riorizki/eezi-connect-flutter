import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/ui/SecondRegister/SecondRegisterViewModel.dart';
import 'package:eezi_connect/ui/SecondRegister/components/widget/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';

class SecondRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SecondRegisterViewModel>.reactive(
      viewModelBuilder: () => SecondRegisterViewModel(),
      onModelReady: (model) => model.onInit(),
      builder: (context, model, child) => Scaffold(
        body: LoadingOverlay(
          isLoading: model.isBusy,
          child: Stack(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 20.w,
                            ),
                            child: Icon(
                              Icons.west,
                              color: COLOR_WHITE,
                              size: 24.w,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 20.w,
                          ),
                          child: Text(
                            'Hi, ${model.username}',
                            style: TextStyle(
                              color: COLOR_WHITE,
                              fontSize: 16.nsp,
                            ),
                          ),
                        ),
                        Container(),
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
                              GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                    Container(
                                      height: 180.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: COLOR_WHITE,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 16.h, bottom: 10.h),
                                            child: Center(
                                              child: Text(
                                                'Pick Image Source',
                                                style: TextStyle(
                                                  fontSize: 14.nsp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              if (Get.isBottomSheetOpen) {
                                                model.pickImageCamera();
                                                Get.back();
                                              }
                                            },
                                            leading: Icon(Icons.camera),
                                            title: Text(
                                              'Camera',
                                              style: TextStyle(
                                                fontSize: 12.nsp,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              if (Get.isBottomSheetOpen) {
                                                model.pickImageGallery();
                                                Get.back();
                                              }
                                            },
                                            leading: Icon(Icons.photo_album),
                                            title: Text(
                                              'Gallery',
                                              style: TextStyle(
                                                fontSize: 12.nsp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: model.returnImage(),
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
                          title: 'Username',
                          hint: 'ex. Joe Doe',
                          controller: model.fullNameController,
                        ),
                        TextFieldComponent(
                          mt: 15,
                          title: 'Phone Number',
                          hint: '+62 818 1080 87',
                          controller: model.phoneController,
                          isEnabled: false,
                        ),
                        TextFieldComponent(
                          mt: 15,
                          title: 'Email/Facebook',
                          hint: 'joedhoe@mail.com',
                          controller: model.emailController,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 55.h),
                          child: GestureDetector(
                            onTap: () {
                              model.completeData();
                            },
                            child: Center(
                              child: Container(
                                width: 86.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: COLOR_ACCENT,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Finish',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: COLOR_PRIMARY_1,
                                    fontSize: 12.nsp,
                                  ),
                                ),
                              ),
                            ),
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

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    Key key,
    this.title,
    this.hint,
    this.mt = 0.0,
    this.mr = 0.0,
    this.mb = 0.0,
    this.ml = 0.0,
    @required this.controller,
    this.isEnabled = true,
  }) : super(key: key);

  final String title;
  final String hint;
  final double mt, mr, mb, ml;
  final TextEditingController controller;
  final bool isEnabled;

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
          TextFieldWidget(
            hint: hint,
            controller: controller,
            isEnabled: isEnabled,
          ),
        ],
      ),
    );
  }
}
