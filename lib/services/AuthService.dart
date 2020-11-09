import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  _printCredentials(_accessToken, LoginResult result) {
    _accessToken = result.accessToken;
    print("userId: ${result.accessToken.userId}");
    print("token: ${_accessToken.toJson()}");
    print("expires: ${result.accessToken.expires}");
    print("grantedPermission: ${result.accessToken.grantedPermissions}");
    print("declinedPermissions: ${result.accessToken.declinedPermissions}");
  }

  Future<User> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();

      switch (result.status) {
        case FacebookAuthLoginResponse.ok:
          // Create a credential from the access token
          final FacebookAuthCredential facebookAuthCredential =
              FacebookAuthProvider.credential(result.accessToken.token);

          final authResult = await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential);
          final User user = authResult.user;

          // Once signed in, return the UserCredential
          return user;

          break;
        case FacebookAuthLoginResponse.cancelled:
          print("login cancelled");

          return null;
          break;
        default:
          print("login failed");

          return null;
      }
    } catch (e) {
      print('$e');
      showErrorBanner('$e');
      return null;
    }
  }

  Future<User> loginGoogle() async {
    try {
      var googleUser = await signInWithGoogleV2();
      if (googleUser != null) {
        return googleUser;
      }
      return null;
    } catch (e) {
      print('$e');
      showErrorBanner('$e');
      return null;
    }
  }

  Future<User> loginFacebook() async {
    try {
      var facebookUser = await signInWithFacebook();
      if (facebookUser != null) {
        print('success login with google');
        print(facebookUser);
        return facebookUser;
      }
    } catch (e) {
      print('$e');
      showErrorBanner('$e');
      return null;
    }
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
    await _auth.signOut();
    await googleSignIn.signOut();
    print("User Signed Out");
  }

  void signOutFacebook() async {
    await FacebookAuth.instance.logOut();
  }

  void showSuccessBanner(String msg) {
    Get.snackbar('Notification', '$msg', backgroundColor: COLOR_CONNECT_1);
  }

  void showErrorBanner(String msg) {
    Get.snackbar('Error', '$msg', backgroundColor: COLOR_RED);
  }
}
