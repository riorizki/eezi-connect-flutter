import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/services/ApiService.dart';
import 'package:eezi_connect/services/StorageService.dart';
import 'package:eezi_connect/ui/Home/Home.dart';
import 'package:eezi_connect/ui/Verification/Verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  TextEditingController phoneController = TextEditingController();
  final ApiService apiService = Get.put(ApiService());
  final StorageService storageService = Get.put(StorageService());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void register() async {
    setLoading(true);
    try {
      var number = phoneController.text;
      if (number.isNullOrBlank) {
        showErrorBanner('Please provide Phone Number');
        setLoading(false);
        return;
      }
      number = '+62$number';
      final data = await apiService.registerPhoneNumber(phoneNumber: '$number');
      showSuccessBanner('Success Register');
      storageService.save('id', '${data.data.id}');
      Get.to(VerificationScreen());
    } catch (e) {
      print(e);
      showErrorBanner('$e');
    }
    setLoading(false);
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

  void loginGoogle() async {
    setLoading(true);
    try {
      var googleUser = await signInWithGoogleV2();
      if (googleUser != null) {
        print('success login with google');
        print(googleUser);
        storageService.save('id', googleUser.photoURL);
        Get.off(HomeScreen());
      }
    } catch (e) {
      print('$e');
      showErrorBanner('$e');
    }
    setLoading(false);
  }

  void loginFacebook() async {
    setLoading(true);
    try {
      var facebookUser = await signInWithFacebook();
      if (facebookUser != null) {
        print('success login with google');
        print(facebookUser);
      }
    } catch (e) {
      print('$e');
      showErrorBanner('$e');
    }
    setLoading(false);
  }

  Future<User> signInWithGoogleV2() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return user;
    }

    return null;
  }

  Future<UserCredential> signInWithFacebook() async {
    // try {
    //   // Trigger the sign-in flow
    //   final LoginResult result = await FacebookAuth.instance.login();
    //
    //   // Create a credential from the access token
    //   final FacebookAuthCredential facebookAuthCredential =
    //       FacebookAuthProvider.credential(result.accessToken.token);
    //
    //   // Once signed in, return the UserCredential
    //   return await FirebaseAuth.instance
    //       .signInWithCredential(facebookAuthCredential);
    // } catch (e) {
    //   print('$e');
    //   showErrorBanner('$e');
    //   return null;
    // }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var user = await FirebaseAuth.instance.signInWithCredential(credential);

      // Once signed in, return the UserCredential
      return user;
    } catch (e) {
      print('$e');
      showErrorBanner('$e');
      return null;
    }
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Signed Out");
  }
}
