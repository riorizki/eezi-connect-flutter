import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/injectable.dart';
import 'package:eezi_connect/models/UserFirebase.dart';
import 'package:eezi_connect/services/AuthService.dart';
import 'package:eezi_connect/services/FirebaseFirestoreService.dart';
import 'package:eezi_connect/services/StorageService.dart';
import 'package:eezi_connect/ui/SplashScreen/SplashScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

Future<dynamic> _onBackgroundMessage(Map<String, dynamic> message) async {
  debugPrint('On background message $message');
  return Future<void>.value();
}

class HomeViewModel extends BaseViewModel {
  final StorageService _storageService = getIt.get<StorageService>();
  final StorageService service = getIt.get<StorageService>();
  final AuthService authService = getIt.get<AuthService>();
  final FirebaseFirestoreService firestoreService =
      getIt.get<FirebaseFirestoreService>();

  int indexMenu = 0;

  List<UserFirebase> users = List<UserFirebase>();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void onInit() {
    checkForLoginType();
    getAllUser();
    requestPermissions();
    registerNotification();
    configLocalNotification();
  }

  void checkForLoginType() {
    final isProviderLogin = _storageService.read('typeLogin');

    if (isProviderLogin == 'true') {
    } else {}
  }

  void requestPermissions() async {
    var status = await Permission.notification.status;

    print(status);

    if (status.isPermanentlyDenied) {
      openAppSettings();
    } else if (!status.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.notification,
      ].request();
    }
  }

  void registerNotification() {
    final currentUserId = _storageService.read('id');
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
        provisional: true,
      ),
    );

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        Platform.isAndroid
            ? showNotification(message['notification'])
            : showNotification(message['aps']['alert']);
      },
      onBackgroundMessage: _onBackgroundMessage,
      onResume: (Map<String, dynamic> message) async {
        print('onResumes => $message');
        Platform.isAndroid
            ? showNotification(message['notification'])
            : showNotification(message['aps']['alert']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch=> $message');
        Platform.isAndroid
            ? showNotification(message['notification'])
            : showNotification(message['aps']['alert']);
      },
    );

    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({'pushToken': token});
    }).catchError((err) {
      showErrorBanner(err.message.toString());
    });
  }

  void configLocalNotification() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(message) async {
    print('notification called => $message');
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      Platform.isAndroid ? 'com.weeo.eezi_connect' : 'com.weeo.eezi_connect',
      'FLUTTER_NOTIFICATION_CLICK',
      'FLUTTER_NOTIFICATION_CLICK',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    print(message);

    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));

    setBusy(false);
  }

  void getAllUser() async {
    try {
      users.clear();
      setBusy(false);

      final data = await firestoreService.getAllUser();
      final id = _storageService.read('id');

      final exceptMe = data.where((element) => element.id != id);

      exceptMe.forEach((element) {
        final user = UserFirebase(
          id: element.id,
          username: element.username,
          avatar: element.avatar,
          email: element.email,
          phoneNumber: element.phoneNumber,
          fullName: element.fullName,
          token: element.token,
          address: element.address,
        );
        users.add(user);
      });
    } catch (e) {
      printError(info: '$e');
      setBusy(false);
    }
    setBusy(false);
  }

  void logout() async {
    authService.signOutGoogle();
    authService.signOutFacebook();
    print("User Signed Out");
    service.remove();
    Get.off(SplashScreen());

    print('called');
  }

  void changeMenuIndex(int index) {
    setBusy(true);
    indexMenu = index;
    setBusy(false);
  }

  void launchBrowser({String url}) async {
    setBusy(true);

    try {
      await launch('$url');
    } catch (e) {
      print(e);
      showErrorBanner('$e');
    }

    setBusy(false);
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

    setBusy(false);
  }

  void showSuccessBanner(String msg) {
    Get.snackbar('Notification', '$msg', backgroundColor: COLOR_CONNECT_1);
  }

  void showErrorBanner(String msg) {
    Get.snackbar('Error', '$msg', backgroundColor: COLOR_RED);
  }
}
