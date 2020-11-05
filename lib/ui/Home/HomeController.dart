import 'package:device_apps/device_apps.dart';
import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/services/StorageService.dart';
import 'package:eezi_connect/ui/SplashScreen/SplashScreen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final isLoading = false.obs;

  final StorageService service = Get.put(StorageService());

  final GoogleSignIn googleSignIn = GoogleSignIn();

  void logout() async {
    await googleSignIn.signOut();
    print("User Signed Out");
    service.remove();
    Get.off(SplashScreen());
  }

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

  void launchBrowser({String url}) async {
    setLoading(true);

    try {
      await launch('$url');
    } catch (e) {
      print(e);
      showErrorBanner('$e');
    }

    setLoading(false);
  }

  void launchApps({String com}) async {
    setLoading(true);

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

    setLoading(false);
  }

  void showSuccessBanner(String msg) {
    Get.snackbar('Notification', '$msg', backgroundColor: COLOR_CONNECT_1);
  }

  void showErrorBanner(String msg) {
    Get.snackbar('Error', '$msg', backgroundColor: COLOR_RED);
  }
}
