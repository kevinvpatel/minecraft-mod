import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:minecraft_mod_flutter/app/data/constants/color_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/widget_constants.dart';
import 'package:minecraft_mod_flutter/app/modules/list_screen/controllers/list_screen_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListWidgets {

  static PreferredSizeWidget appBar({required double width, required ListScreenController controller, required AdService adService}) {
    return ConstantsWidgets.appBarConstant(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 19.sp,
            child: TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {
                  adService.checkBackCounterAd();
                  Get.back();
                },
                child: Image.asset(ConstantsImage.back)
            ),
          ),
          SizedBox(
            height: 26.5.sp,
            width: width * 0.55,
            child: TextField(
              controller: controller.searchController,
              cursorColor: Colors.brown,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 15),
                filled: true,
                fillColor: ConstantsColor.orange100,
                hintStyle: TextStyle(fontSize: 17.5.sp, color: Colors.brown),
                hintText: 'Search here...',
                suffixIcon: Container(width: 18.5.sp, margin: EdgeInsets.only(right: 10), child: Image.asset(ConstantsImage.search)),
                suffixIconConstraints: BoxConstraints(maxHeight: 40, maxWidth: 40),
              ),
              onTap: () {},
              onChanged: (text) {},
            ),
          )
        ],
      )
    );
  }

}