import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/services/ApiService.dart';
import 'package:eezi_connect/services/StorageService.dart';
import 'package:eezi_connect/ui/FirstRegister/FirstRegister.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
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

  void verification() async {
    setLoading(true);
    try {
      var pin = textController.text;
      if (pin.isNullOrBlank) {
        showErrorBanner('Please provide verification code');
        setLoading(false);
        return;
      }
      final userId = storageService.read('id');
      final response =
          await apiService.verificationToken(userId: '$userId', token: '$pin');
      Get.off(FirstRegisterScreen());
    } catch (e) {
      print(e);
      showErrorBanner('$e');
    }
    setLoading(false);
  }
}
