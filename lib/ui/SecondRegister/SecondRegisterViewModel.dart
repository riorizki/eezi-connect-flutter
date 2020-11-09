import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/injectable.dart';
import 'package:eezi_connect/models/UserFirebase.dart';
import 'package:eezi_connect/services/ApiService.dart';
import 'package:eezi_connect/services/FirebaseFirestoreService.dart';
import 'package:eezi_connect/services/StorageService.dart';
import 'package:eezi_connect/ui/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class SecondRegisterViewModel extends BaseViewModel {
  final ApiService apiService = getIt.get<ApiService>();
  final StorageService storageService = getIt.get<StorageService>();

  final FirebaseFirestoreService _firebaseFirestoreService =
      getIt.get<FirebaseFirestoreService>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String username = '';

  String imagePicked;
  String urlImage;
  bool afterPicked = false;

  final picker = ImagePicker();

  void onInit() {
    setBusy(true);

    phoneController.text = storageService.read('number');
    username = storageService.read('username');

    setValueTextField();

    setBusy(false);
  }

  void setValueTextField() {
    final username = storageService.read('username');
    final email = storageService.read('emailTemp');
    final photoUrl = storageService.read('photoUrl');

    urlImage = photoUrl;
    fullNameController.text = username;
    emailController.text = email;
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

  void showSuccessBanner(String msg) {
    Get.snackbar('Notification', '$msg', backgroundColor: COLOR_CONNECT_1);
  }

  void showErrorBanner(String msg) {
    Get.snackbar('Error', '$msg', backgroundColor: COLOR_RED);
  }

  void skip() {
    Get.off(HomeScreen());
  }

  void completeDataProvider(String id) async {
    setBusy(true);
    final loginType = storageService.read('kindLogin');

    String username = fullNameController.text;
    String phone = phoneController.text;
    String email = emailController.text;

    if (username.isNullOrBlank) {
      showErrorBanner('Please provide username');
      setBusy(false);
      return;
    }

    username = GetUtils.removeAllWhitespace(username).toLowerCase();
    final usernameExist = await checkForUsername(username);

    if (usernameExist) {
      showErrorBanner('Username is exist, please choose another username!');
      setBusy(false);
      return;
    }

    var url = '';

    if (!GetUtils.isNullOrBlank(imagePicked)) {
      url = await _firebaseFirestoreService.uploadFile(id, imagePicked);
      urlImage = url;
    } else {
      final user = await _firebaseFirestoreService.getUser(id);
      url = user.avatar;
    }

    await _firebaseFirestoreService.updateDynamicUser(id, {
      'username': username,
      'loginProvider': loginType,
      'email': email,
      'phoneNumber': phone,
      'avatar': url,
    });
    setBusy(false);
    storageService.save('username', '$username');
    Get.off(HomeScreen());
  }

  void completePhoneNumber() async {
    setBusy(true);

    try {
      String fullName = fullNameController.text;
      String phone = phoneController.text;
      String email = emailController.text;
      username = storageService.read('username');

      if (email.isNullOrBlank ||
          phone.isNullOrBlank ||
          fullName.isNullOrBlank) {
        showErrorBanner('Please fill all text field');
        setBusy(false);

        return;
      }

      final pNumber = storageService.read('number');
      username = GetUtils.removeAllWhitespace(username).toLowerCase();

      final isExist = await checkForUsername(username);
      if (isExist) {
        showErrorBanner('Username is taken. Please use another Username!');
        setBusy(false);

        return;
      }

      UserFirebase user = UserFirebase(
        username: username,
        phoneNumber: pNumber,
        email: email,
        loginProvider: 'phoneNumber',
      );

      final data = await _firebaseFirestoreService.addUser(user);

      storageService.save('id', '$data');

      var url = '';

      if (!GetUtils.isNullOrBlank(imagePicked)) {
        url = await _firebaseFirestoreService.uploadFile(data, imagePicked);
        urlImage = url;
      } else {
        url = user.avatar;
      }

      await _firebaseFirestoreService.updateDynamicUser(data, {
        'id': data,
        'avatar': url,
      });

      Get.off(HomeScreen());
    } catch (e) {
      print(e);
      showErrorBanner('$e');
    }

    setBusy(false);
  }

  void completeData() async {
    final isProviderLogin = storageService.read('typeLogin');

    if (isProviderLogin == 'true') {
      final id = storageService.read('id');
      completeDataProvider(id);
    } else {
      completePhoneNumber();
    }
  }

  Future<bool> checkForUsername(String username) async {
    final users = await _firebaseFirestoreService.usersCollection
        .where('username', isEqualTo: username)
        .get();

    final documents = users.docs;

    if (documents.length > 0) {
      return true;
    }

    return false;
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
