import 'package:device_apps/device_apps.dart';
import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/injectable.dart';
import 'package:eezi_connect/services/AuthService.dart';
import 'package:eezi_connect/services/StorageService.dart';
import 'package:eezi_connect/ui/SplashScreen/SplashScreen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewModel extends BaseViewModel {
  final StorageService service = getIt.get<StorageService>();
  final AuthService authService = getIt.get<AuthService>();

  void logout() async {
    authService.signOutGoogle();
    print("User Signed Out");
    service.remove();
    Get.off(SplashScreen());
  }

  void launchBrowser({String url}) async {
    setBusy(true);

    try {
      await launch('$url');
    } catch (e) {
      print(e);
      showErrorBanner('$e');
    }

    setBusy((false);
  }

  void launchApps({String com}) async {
    setBusy(true);

    try {
      bool isInstalled = await DeviceApps.isAppInstalled('$com');
      if (!isInstalled) {
        showErrorBanner('Application is not installed!');
      } else {
        DeviceApps.openApp('$com');
        print('open an appps');
      }
    } catch (e) {
      print(e);
      showErrorBanner('$e');
    }

    setBusy((false);
  }

  void showSuccessBanner(String msg) {
    Get.snackbar('Notification', '$msg', backgroundColor: COLOR_CONNECT_1);
  }

  void showErrorBanner(String msg) {
    Get.snackbar('Error', '$msg', backgroundColor: COLOR_RED);
  }
}
