import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/ui/Home/Home.dart';
import 'package:eezi_connect/ui/SecondRegister/SecondRegister.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eezi_connect/services/ApiService.dart';
import 'package:eezi_connect/services/StorageService.dart';

class FirstRegisterController extends GetxController {
  final isLoading = false.obs;
  final ApiService apiService = Get.put(ApiService());
  final StorageService storageService = Get.put(StorageService());

  TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void setLoading(bool loading) {
    isLoading.value = loading;
  }

  void showSuccessBanner(String msg) {
    Get.snackbar('Notification', '$msg', backgroundColor: COLOR_CONNECT_1);
  }

  void showErrorBanner(String msg) {
    Get.snackbar('Error', '$msg', backgroundColor: COLOR_RED);
  }

  void skip() {
    setLoading(true);

    var username = textController.text;
    if (username.isNullOrBlank) {
      showErrorBanner('Please provide username');
      setLoading(false);
      return;
    }
    storageService.save('username', '$username');

    Get.off(HomeScreen());
    setLoading(false);
  }

  void completeData() {
    setLoading(true);

    var username = textController.text;
    if (username.isNullOrBlank) {
      showErrorBanner('Please provide username');
      setLoading(false);
      return;
    }
    storageService.save('username', '$username');

    Get.to(SecondRegisterScreen());

    setLoading(false);
  }
}
