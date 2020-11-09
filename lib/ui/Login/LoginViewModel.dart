import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/injectable.dart';
import 'package:eezi_connect/models/UserFirebase.dart';
import 'package:eezi_connect/services/ApiService.dart';
import 'package:eezi_connect/services/AuthService.dart';
import 'package:eezi_connect/services/FirebaseFirestoreService.dart';
import 'package:eezi_connect/services/StorageService.dart';
import 'package:eezi_connect/ui/FirstRegister/FirstRegister.dart';
import 'package:eezi_connect/ui/Home/Home.dart';
import 'package:eezi_connect/ui/Verification/Verification.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController phoneController = TextEditingController();

  final ApiService apiService = getIt.get<ApiService>();
  final StorageService storageService = getIt.get<StorageService>();
  final AuthService authService = getIt.get<AuthService>();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseFirestoreService _firebaseFirestoreService =
      getIt.get<FirebaseFirestoreService>();

  String countryCode = '+62';

  void onDropDownChangedValue(val) {
    if (val == 1) {
      countryCode = '+62';
    } else if (val == 2) {
      countryCode = '+81';
    } else if (val == 3) {
      countryCode = '+39';
    } else {
      countryCode = '+62';
    }

    print('onDropDownChangedValue => $countryCode');
  }

  void register() async {
    setBusy(true);

    try {
      var number = phoneController.text;

      if (number.isNullOrBlank) {
        showErrorBanner('Please provide Phone Number');
        setBusy(false);
        return;
      }
      number = '$countryCode$number';

      final data = await apiService.registerPhoneNumber(phoneNumber: '$number');

      final result = await usersCollection
          .where('phoneNumber', isEqualTo: number)
          .where('loginProvider', isEqualTo: 'phoneNumber')
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      print('phone number => $number');

      print('documents.length => ${documents.length}');

      if (documents.length > 0) {
        print(result.docs[0]['id']);
        storageService.save('user', 'true');
        storageService.save('id', '${result.docs[0]['id']}');
        storageService.save('idTemp', '${data.data.id}');
      } else {
        storageService.save('user', 'false');
        storageService.save('id', '${data.data.id}');
      }

      showSuccessBanner('Success');
      storageService.save('number', '$number');

      setBusy(false);

      Get.to(VerificationScreen());
    } catch (e) {
      print(e);
      showErrorBanner('$e');
      setBusy(false);
    }
    setBusy(false);
  }

  void loginFb() async {
    setBusy(true);

    try {
      final user = await authService.loginFacebook();

      if (!GetUtils.isNullOrBlank(user)) {
        final phoneNumber = user.phoneNumber;
        final email = user.email;
        final photoUrl = user.photoURL;
        final fullName = user.displayName;

        final result = await usersCollection
            .where('email', isEqualTo: email)
            .where('fullName', isEqualTo: user.displayName)
            .where('loginProvider', isEqualTo: 'facebook')
            .get();

        final List<DocumentSnapshot> documents = result.docs;

        if (documents.length > 0) {
          print('user already exist ${result.docs[0]['id']}');

          storageService.save('user', 'true');
          storageService.save('id', '${result.docs[0]['id']}');
          final username = result.docs[0]['username'];
          if (!GetUtils.isNullOrBlank(username)) {
            Get.off(HomeScreen());
            return;
          }
          return;
        } else {
          print('user new');

          // Create user
          UserFirebase userFirebase = UserFirebase(
            avatar: photoUrl,
            email: email,
            fullName: fullName,
            phoneNumber: phoneNumber,
            loginProvider: 'facebook',
          );

          // Insert data to firebase
          final data = await _firebaseFirestoreService.addUser(userFirebase);

          await _firebaseFirestoreService.updateDynamicUser(data, {
            'id': data,
          });

          storageService.save('user', 'false');
          storageService.save('id', '$data');
        }

        storageService.save('typeLogin', 'true');
        storageService.save('kindLogin', 'facebook');
        storageService.save('emailTemp', '$email');
        storageService.save('photoUrl', '$photoUrl');

        Get.off(FirstRegisterScreen());
      }
    } catch (e) {
      showErrorBanner('$e');
      setBusy(false);
    }
    setBusy(false);
  }

  void loginGoogle() async {
    setBusy(true);

    try {
      final user = await authService.loginGoogle();

      if (!GetUtils.isNullOrBlank(user)) {
        final phoneNumber = user.phoneNumber;
        final email = user.email;
        final photoUrl = user.photoURL;
        final fullName = user.displayName;

        final result = await usersCollection
            .where('email', isEqualTo: email)
            .where('fullName', isEqualTo: user.displayName)
            .where('loginProvider', isEqualTo: 'google')
            .get();

        final List<DocumentSnapshot> documents = result.docs;

        if (documents.length > 0) {
          print('user already exist => ${result.docs[0]['id']}');

          storageService.save('user', 'true');
          storageService.save('id', '${result.docs[0]['id']}');

          final username = result.docs[0]['username'];
          if (!GetUtils.isNullOrBlank(username)) {
            Get.off(HomeScreen());
            return;
          }
        } else {
          print('user new');

          // Create user
          UserFirebase userFirebase = UserFirebase(
            avatar: photoUrl,
            email: email,
            fullName: fullName,
            phoneNumber: phoneNumber,
            loginProvider: 'google',
          );

          // Insert data to firebase
          final data = await _firebaseFirestoreService.addUser(userFirebase);

          await _firebaseFirestoreService.updateDynamicUser(data, {
            'id': data,
          });

          storageService.save('user', 'false');
          storageService.save('id', '$data');
        }

        storageService.save('typeLogin', 'true');
        storageService.save('kindLogin', 'google');
        storageService.save('emailTemp', '$email');
        storageService.save('photoUrl', '$photoUrl');

        Get.off(FirstRegisterScreen());
      }
    } catch (e) {
      showErrorBanner('$e');
      setBusy(false);
    }

    setBusy(false);
  }

  void showSuccessBanner(String msg) {
    Get.snackbar('Notification', '$msg', backgroundColor: COLOR_CONNECT_1);
  }

  void showErrorBanner(String msg) {
    Get.snackbar('Error', '$msg', backgroundColor: COLOR_RED);
  }
}
