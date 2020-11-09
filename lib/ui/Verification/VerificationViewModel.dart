import 'dart:async';

import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/injectable.dart';
import 'package:eezi_connect/services/ApiService.dart';
import 'package:eezi_connect/services/StorageService.dart';
import 'package:eezi_connect/ui/FirstRegister/FirstRegister.dart';
import 'package:eezi_connect/ui/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class VerificationViewModel extends BaseViewModel {
  final ApiService apiService = getIt.get<ApiService>();
  final StorageService storageService = getIt.get<StorageService>();

  TextEditingController textController = TextEditingController();

  String phoneNumber;

  Timer timer;

  int timerTick = 30;

  bool buttonEnable = true;

  void onInit() {
    setBusy(true);

    phoneNumber = storageService.read('number');

    setBusy(false);
  }

  @override
  void dispose() {
    print('dispose called');
    timer?.cancel();
    super.dispose();
  }

  void setTimer() {
    if (buttonEnable) {
      buttonEnable = false;

      requestNewToken();

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        timerTick -= 1;
        if (timerTick == 0) {
          timer?.cancel();
          timerTick = 30;
          buttonEnable = true;
        }
        notifyListeners();
      });
    }
  }

  void requestNewToken() async {
    setBusy(true);
    try {
      String phoneNumber = storageService.read('number');
      if (!GetUtils.isNullOrBlank(phoneNumber)) {
        final data =
            await apiService.registerPhoneNumber(phoneNumber: '$phoneNumber');
        setBusy(false);
      }
      setBusy(false);
    } catch (e) {
      setBusy(false);
      showErrorBanner('$e');
    }
    setBusy(false);
  }

  void showSuccessBanner(String msg) {
    Get.snackbar('Notification', '$msg', backgroundColor: COLOR_CONNECT_1);
  }

  void showErrorBanner(String msg) {
    Get.snackbar('Error', '$msg', backgroundColor: COLOR_RED);
  }

  void verification() async {
    setBusy(true);

    try {
      String pin = textController.text;

      if (pin.isNullOrBlank) {
        showErrorBanner('Please provide verification code');
        setBusy(false);
        return;
      }

      String userId = '';
      final userData = storageService.read('user');

      if (userData == 'true') {
        userId = storageService.read('idTemp');
      } else {
        userId = storageService.read('id');
      }

      print('userId => $userId');

      final response =
          await apiService.verificationToken(userId: '$userId', token: '$pin');

      if (userData == 'true') {
        Get.off(HomeScreen());
      } else {
        Get.off(FirstRegisterScreen());
      }
    } catch (e) {
      print(e);
      showErrorBanner('$e');
    }

    setBusy(false);
  }
}
