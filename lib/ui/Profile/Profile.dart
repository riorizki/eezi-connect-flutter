import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/ui/Profile/ProfileViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';

import 'AppBar/AppBar.dart';
import 'TextFieldWidget.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) => model.onInit(),
      builder: (context, model, child) => Scaffold(
        body: LoadingOverlay(
          isLoading: model.isBusy,
          child: model.isBusy
              ? Stack(
                  children: [
                    AppBarComponent(username: 'Username'),
                    Positioned(
                      top: 90.h,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 550.h,
                        width: double.infinity,
                        color: COLOR_WHITE,
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    AppBarComponent(
                      username: model.user.username,
                    ),
                    BodyComponent(
                      model: model,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class BodyComponent extends StatelessWidget {
  const BodyComponent({
    Key key,
    this.model,
  }) : super(key: key);

  final ProfileViewModel model;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                          'Update your profile picture',
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
                  controller: model.phoneNumberController,
                ),
                TextFieldComponent(
                  mt: 15,
                  title: 'Email/Facebook',
                  hint: 'joedhoe@mail.com',
                  controller: model.emailController,
                ),
                Container(
                  margin: EdgeInsets.only(top: 55.h, right: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 86.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: COLOR_CONNECT_1,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: COLOR_WHITE,
                              fontSize: 12.nsp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 44.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          model.updateProfile();
                        },
                        child: Container(
                          width: 86.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: COLOR_ACCENT,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: COLOR_PRIMARY_1,
                              fontSize: 12.nsp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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
  }) : super(key: key);

  final String title;
  final String hint;
  final double mt, mr, mb, ml;
  final TextEditingController controller;

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
          TextFieldWidget(hint: hint, controller: controller),
        ],
      ),
    );
  }
}
