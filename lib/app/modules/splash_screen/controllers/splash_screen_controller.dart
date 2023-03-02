import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:minecraft_mod_flutter/app/data/internet_check_service.dart';
import 'package:minecraft_mod_flutter/app/modules/home/views/home_view.dart';
import 'package:minecraft_mod_flutter/main.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  final popupCounter = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print('Splash screen oninit');

    StreamSubscription<InternetConnectionStatus> listener =
    InternetConnectionChecker().onStatusChange.listen(
          (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
          // Do what you want to do
            if(configData.value != {}) {
              if(popupCounter.value == 1) {
                Navigator.pop(Get.overlayContext!);
              }
              print('Get.previousRoute -> ${Get.previousRoute}');
              print('Get.currentRoute -> ${Get.currentRoute}');
              if(Get.currentRoute == '/splash-screen') {
                Future.delayed(Duration(seconds: 3), () {Get.off(HomeView());});
              }
            } else {
              initConfig().whenComplete(() {
                configData.value = json.decode(remoteConfig.getString('Ad'));
                initAppOpenAd();
              });
            }
            break;
          case InternetConnectionStatus.disconnected:
          // Do what you want to do
            popupCounter.value = 1;
            print('InternetConnectionStatus.disconnected -> ${InternetConnectionStatus.disconnected}');
            showDialog(
                context: Get.overlayContext!,
                builder: (context) {
                  return WillPopScope(child: AlertDialog(
                    content: Row(
                      children: const [
                        // CircularProgressIndicator(),
                        Spacer(),
                        Text('Please turn on internet..'),
                        Spacer(),
                      ],
                    ),
                  ), onWillPop: () => Future.value(false),);
                }
            );
            break;
        }
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
