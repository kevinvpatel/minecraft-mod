import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/constants/color_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';

class CategoryWidgets {

  static PreferredSizeWidget appBar({required double width}) {
    return AppBar(
      leadingWidth: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: (){Get.back();},
                child: Image.asset(ConstantsImage.back, height: 22)
            ),
          ),
        ],
      ),
      backgroundColor: ConstantsColor.orange50,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
    );
  }

}