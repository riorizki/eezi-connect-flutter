import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/ui/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eezi_connect/services/ApiService.dart';
import 'package:eezi_connect/services/StorageService.dart';

class SecondRegisterController extends GetxController {
  final isLoading = false.obs;
  final ApiService apiService = Get.put(ApiService());
  final StorageService storageService = Get.put(StorageService());

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
    Get.off(HomeScreen());
  }

  void completeData() async {
    setLoading(true);
    try {
      var fullName = fullNameController.text;
      var phone = phoneController.text;
      var email = emailController.text;
      var address = addressController.text;

      print(fullName);
      print(phone);
      print(email);
      print(address);

      if (address.isNullOrBlank ||
          email.isNullOrBlank ||
          phone.isNullOrBlank ||
          fullName.isNullOrBlank) {
        showErrorBanner('Please fill all text field');
        setLoading(false);
        return;
      }
      final username = storageService.read('username');
      final userId = storageService.read('id');

      final response = await apiService.updateUserData(
        user_id: userId,
        username: username,
        phoneNumber: phone,
        address: address,
        avatar: '',
        email: email,
        fullName: fullName,
      );

      Get.off(HomeScreen());
    } catch (e) {
      print(e);
      showErrorBanner('$e');
    }

    setLoading(false);
  }
}
