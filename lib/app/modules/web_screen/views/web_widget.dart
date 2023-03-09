import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/widget_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WebWidget {

  static PreferredSizeWidget appBar({required double width, required AdService adService}) {
    return ConstantsWidgets.appBarConstant(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 18.sp,
              child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    adService.checkBackCounterAd();
                    Get.back();
                  },
                  child: Image.asset(ConstantsImage.back)
              ),
            ),
          ],
        )
    );
  }

}