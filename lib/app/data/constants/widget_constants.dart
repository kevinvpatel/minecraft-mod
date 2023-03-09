import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minecraft_mod_flutter/app/data/constants/color_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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


  static PreferredSizeWidget appBarConstant ({required Widget child}) {
    return AppBar(
      toolbarHeight: 30.sp,
      leadingWidth: 0,
      title: child,
      backgroundColor: ConstantsColor.orange50,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18))),
    );
  }


}