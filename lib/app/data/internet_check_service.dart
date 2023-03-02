import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetCheckService {

  static RxInt dialogeCounter = 0.obs;

  static StreamSubscription<InternetConnectionStatus> listener =
  InternetConnectionChecker().onStatusChange.listen(
        (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
        // Do what you want to do
          if(dialogeCounter.value == 1) {Navigator.pop(Get.overlayContext!);}
          break;
        case InternetConnectionStatus.disconnected:
        // Do what you want to do
          dialogeCounter.value = 1;
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