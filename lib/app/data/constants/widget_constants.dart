import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConstantsWidgets {

  static Widget progressBarAndroid () => const Center(child: CircularProgressIndicator(color: Colors.brown));
  static Widget progressBariOS () => const Center(child: CupertinoActivityIndicator());

  static String k_m_b_generator({required int num}) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }



}