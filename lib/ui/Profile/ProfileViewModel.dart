import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/injectable.dart';
import 'package:eezi_connect/models/UserFirebase.dart';
import 'package:eezi_connect/services/FirebaseFirestoreService.dart';
import 'package:eezi_connect/services/StorageService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final StorageService _storageService = getIt.get<StorageService>();
  final FirebaseFirestoreService _fireStoreService =
      getIt.get<FirebaseFirestoreService>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  UserFirebase user;

  String imagePicked;
  String urlImage;
  bool afterPicked = false;

  final picker = ImagePicker();

  void onInit() async {
    setBusy(true);
    await loadProfile();
    setBusy(false);
  }

  Future<void> loadProfile() async {
    setBusy(true);
    try {
      final id = _storageService.read('id');
      print('id is => $id');
      user = await _fireStoreService.getUser(id);
      urlImage = user.avatar;
      setProfile();
    } catch (e) {
      showErrorBanner('$e');
      setBusy(false);
    }
    setBusy(false);
  }

  void setProfile() {
    fullNameController.text = user.username;
    phoneNumberController.text = user.phoneNumber;
    emailController.text = user.email;
  }

  void pickImageCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    if (pickedFile != null) {
      imagePicked = File(pickedFile.path).path;
      afterPicked = true;
    } else {
      showErrorBanner('No image picked');
    }

    setBusy(false);
  }

  void pickImageGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);

    if (pickedFile != null) {
      imagePicked = File(pickedFile.path).path;
      afterPicked = true;
    } else {
      showErrorBanner('No image picked');
    }

    setBusy(false);
  }

  void updateProfile() async {
    setBusy(true);

    try {
      final fName = fullNameController.text;
      final pNumber = phoneNumberController.text;
      final email = emailController.text;
      final id = _storageService.read('id');
      final username = _storageService.read('username');
      var url = '';

      if (!GetUtils.isNullOrBlank(imagePicked)) {
        url = await _fireStoreService.uploadFile(id, imagePicked);
        urlImage = url;
      } else {
        url = user.avatar;
      }

      if (username != fName) {
        final isExist = await checkForUsername(
            GetUtils.removeAllWhitespace(fName).toLowerCase());
        if (isExist) {
          showErrorBanner('Username is taken. Please use another Username!');
          setBusy(false);

          return;
        }
      }

      _storageService.save(
          'username', '${GetUtils.removeAllWhitespace(fName).toLowerCase()}');

      final data = await _fireStoreService.updateDynamicUser(id, {
        'avatar': url,
        'username': GetUtils.removeAllWhitespace(fName).toLowerCase(),
        'email': email,
        'phoneNumber': pNumber,
      });

      showSuccessBanner('Success Update Profile!');
      afterPicked = false;
      imagePicked = null;

      onInit();

      setBusy(false);
    } catch (e) {
      showErrorBanner('$e');
      setBusy(false);
    }

    setBusy(false);
  }

  Future<bool> checkForUsername(String username) async {
    final users = await _fireStoreService.usersCollection
        .where('username', isEqualTo: username)
        .get();

    final documents = users.docs;

    if (documents.length > 0) {
      return true;
    }

    return false;
  }

  bool validate() {
    final fName = fullNameController.text;
    final pNumber = phoneNumberController.text;
    final email = emailController.text;

    if (GetUtils.isNullOrBlank(fName) ||
        GetUtils.isNullOrBlank(pNumber) ||
        GetUtils.isNullOrBlank(email)) {
      return false;
    }

    return true;
  }

  void showSuccessBanner(String msg) {
    Get.snackbar('Notification', '$msg', backgroundColor: COLOR_CONNECT_1);
  }

  void showErrorBanner(String msg) {
    Get.snackbar('Error', '$msg', backgroundColor: COLOR_RED);
  }

  Widget returnImage() {
    final imageLocal = GetUtils.isNullOrBlank(imagePicked);
    final imageOnline = GetUtils.isNullOrBlank(urlImage);

    if (imageOnline && imageLocal) {
      return Container(
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
      );
    } else if (imageOnline && !imageLocal) {
      return Container(
        width: 72.w,
        height: 75.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: COLOR_GRAY),
          image: DecorationImage(
            image: FileImage(
              File(imagePicked),
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (!imageOnline && imageLocal) {
      return Container(
        width: 72.w,
        height: 75.h,
        child: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(urlImage),
          radius: 36.w,
        ),
      );
    } else if (!imageOnline && !imageLocal) {
      if (afterPicked) {
        return Container(
          width: 72.w,
          height: 75.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: COLOR_GRAY),
            image: DecorationImage(
              image: FileImage(
                File(imagePicked),
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      } else {
        return Container(
          width: 72.w,
          height: 75.h,
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(urlImage),
            radius: 36.w,
          ),
        );
      }
    }

    return Container(
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
    );
  }
}
