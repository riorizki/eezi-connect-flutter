import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/injectable.dart';
import 'package:eezi_connect/models/UserFirebase.dart';
import 'package:eezi_connect/services/ApiService.dart';
import 'package:eezi_connect/services/FirebaseFirestoreService.dart';
import 'package:eezi_connect/services/StorageService.dart';
import 'package:eezi_connect/ui/Home/Home.dart';
import 'package:eezi_connect/ui/SecondRegister/SecondRegister.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class FirstRegisterViewModel extends BaseViewModel {
  final ApiService apiService = getIt.get<ApiService>();
  final StorageService storageService = getIt.get<StorageService>();
  final FirebaseFirestoreService _firebaseFireStoreService =
      getIt.get<FirebaseFirestoreService>();

  TextEditingController textController = TextEditingController();

  void showSuccessBanner(String msg) {
    Get.snackbar('Notification', '$msg', backgroundColor: COLOR_CONNECT_1);
  }

  void showErrorBanner(String msg) {
    Get.snackbar('Error', '$msg', backgroundColor: COLOR_RED);
  }

  void onInit() {
    checkProviderLogin();
  }

  void checkProviderLogin() async {
    final isProviderLogin = storageService.read('typeLogin');
    print('isProviderLogin = > $isProviderLogin');

    if (!GetUtils.isNullOrBlank(isProviderLogin)) {
      if (isProviderLogin == 'true') {
        final id = storageService.read('id');
        final user = await _firebaseFireStoreService.getUser(id);
        textController.text = user.username;
      }
    }
  }

  void skipProvider(String id) async {
    setBusy(true);
    final loginType = storageService.read('kindLogin');

    var username = textController.text;
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

    await _firebaseFireStoreService.updateDynamicUser(id, {
      'username': username,
      'loginProvider': loginType,
    });

    storageService.save('username', '$username');
    setBusy(false);
    Get.off(HomeScreen());
  }

  void skip() async {
    final isProviderLogin = storageService.read('typeLogin');

    if (isProviderLogin == 'true') {
      final id = storageService.read('id');
      skipProvider(id);
    } else {
      skipPhoneNumber();
    }
  }

  void skipPhoneNumber() async {
    setBusy(true);

    var username = textController.text;
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

    storageService.save('username', '$username');
    final pNumber = storageService.read('number');

    UserFirebase user = UserFirebase(
      username: username,
      phoneNumber: pNumber,
      loginProvider: 'phoneNumber',
    );

    final data = await _firebaseFireStoreService.addUser(user);
    await _firebaseFireStoreService.updateDynamicUser(data, {
      'id': data,
    });

    storageService.save('id', '$data');
    Get.off(HomeScreen());

    setBusy(false);
  }

  void completeData() async {
    setBusy(true);
    var username = textController.text;
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
    storageService.save('username', '$username');
    Get.to(SecondRegisterScreen());

    setBusy(false);
  }

  Future<bool> checkForUsername(String username) async {
    final users = await _firebaseFireStoreService.usersCollection
        .where('username', isEqualTo: username)
        .get();

    final documents = users.docs;

    if (documents.length > 0) {
      return true;
    }

    return false;
  }
}
