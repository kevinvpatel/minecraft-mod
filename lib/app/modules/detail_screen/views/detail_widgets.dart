import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/constants/color_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/widget_constants.dart';
import 'package:minecraft_mod_flutter/app/modules/detail_screen/controllers/detail_screen_controller.dart';
import 'package:minecraft_mod_flutter/app/modules/info_screen/views/info_screen_view.dart';
import 'package:share_plus/share_plus.dart';

class DetailWidgets {

  static PreferredSizeWidget appBar({required double width, required DetailScreenController controller}) {
    return AppBar(
      leadingWidth: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 20,
            child: TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: (){Get.back();},
                child: Image.asset(ConstantsImage.back, height: 22)
            ),
          ),
          sideMenu(width: width, controller: controller)
        ],
      ),
      backgroundColor: ConstantsColor.orange50,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
    );
  }


  static sideMenu({required double width, required DetailScreenController controller}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
          buttonSplashColor: Colors.transparent,
          buttonHighlightColor: Colors.transparent,
          itemHighlightColor: Colors.transparent,
          itemSplashColor: Colors.transparent,
          dropdownWidth: width * 0.48,
          dropdownPadding: const EdgeInsets.only(top: 15),
          customButton: Container(
            height: 45,
            width: 45,
            padding: const EdgeInsets.all(11.5),
            child: Image.asset(ConstantsImage.dotMenu)
          ),
          dropdownDecoration: BoxDecoration(
              color: const Color.fromRGBO(251, 240, 209, 1),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 18, spreadRadius: 2, offset: Offset(0, 4))]
          ),
          buttonDecoration: const BoxDecoration(color: Color.fromRGBO(251, 240, 209, 1)),
          alignment: Alignment.center,
          items: List.generate(controller.lstSideMenuTitle.value.length, (index) {
            return DropdownMenuItem(
                value: controller.lstSideMenuTitle.value[index],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 0.35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(controller.lstSideMenuIcon.value[index], height: 20, width: 20),
                          const SizedBox(width: 20),
                          Text(controller.lstSideMenuTitle.value[index], style: const TextStyle(color: Colors.brown)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Divider(indent: 2, endIndent: 2, color: index != controller.lstSideMenuTitle.value.length - 1 ? Colors.brown.shade400 : Colors.transparent, thickness: 1)
                  ],
                )
            );
          }),
          value: controller.selectedSideMenu?.value,
          onChanged: (val) {
            if(val == 'Privacy Policy') {
            } else if(val == 'Info') {
              Get.to(const InfoScreenView());
            } else {
              Share.share('check out my website https://example.com');
            }
          }
      ),
    );
  }



  static Widget chipTag({
    required String title,
    required Color backgroundColor,
    Color? textColor,
    double sidePadding = 16,
    double verticalPadding = 7,
    double fontSize = 14
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(7)
      ),
      padding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: verticalPadding),
      margin: EdgeInsets.only(right: 10),
      child: Text(title, style: TextStyle(color: textColor, fontSize: fontSize),),
    );
  }

  static Widget imageIcon({required String data, required double width, required String image, required double imageHeight, bool isVersion = false}) {
    return Container(
      height: 50,
      width: width * 0.215,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(image, height: imageHeight),
          SizedBox(height: 3),
          Text(isVersion ? data+'+' : ConstantsWidgets.k_m_b_generator(num: int.parse(data)), style: TextStyle(fontSize: 14, color: Colors.grey.shade700))
        ],
      ),
    );
  }


}