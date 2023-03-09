import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:minecraft_mod_flutter/app/data/constants/color_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/widget_constants.dart';
import 'package:minecraft_mod_flutter/app/modules/category_screen/views/category_screen_view.dart';
import 'package:minecraft_mod_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:minecraft_mod_flutter/app/modules/info_screen/views/info_screen_view.dart';
import 'package:minecraft_mod_flutter/app/modules/web_screen/views/web_screen_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';

class HomeWidgets {

  static PreferredSizeWidget appBar({required double width, required HomeController controller}) {
    return ConstantsWidgets.appBarConstant(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: (){
                print('tap appbar title');
                controller.scaffoldKey.currentState?.openDrawer();
              },
              child: Image.asset(ConstantsImage.fullMenu, height: 19.sp)
          ),
          Icon(Icons.notifications_rounded, color: Colors.brown, size: 21.sp)
        ],
      )
    );
  }

  static drawer({required double width, required AdService adService}) {
    return Container(
      width: width * 0.81,
      color: Colors.white,
      child: Column(
        children: [
          ///Header
          Container(
            height: width * 0.6,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(ConstantsImage.drawerBackground), alignment: Alignment.centerRight, fit: BoxFit.fitWidth)
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.black38,
                  width: width,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: PhysicalModel(
                    elevation: 12,
                    borderRadius: BorderRadius.circular(15),
                    shadowColor: Colors.white30,
                    color: Colors.transparent,
                    child: Image.asset(ConstantsImage.LOGO1080, height: width * 0.35, width: width * 0.35)
                  ),
                )
              ],
            )
          ),
          const Divider(height: 0),
          const SizedBox(height: 18),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 15),
            child: Text('PRIVACY & INFO', style: TextStyle(color: Colors.grey.shade600, fontSize: 17.sp, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 10),
          ///Items
          Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    drawerItem(title: 'Home', image: ConstantsImage.drawer_home, onTap: () => Get.back()),
                    drawerItem(title: 'Category', image: ConstantsImage.drawer_category, onTap: () {
                      adService.checkCounterAd();
                      Get.to(CategoryScreenView());
                    }),
                    drawerItem(title: 'Rate App', image: ConstantsImage.drawer_rating, onTap: () {
                      LaunchReview.launch(androidAppId: 'com.minecraft.mod.minecraft_mod_flutter');
                    }),
                    drawerItem(title: 'Info', image: ConstantsImage.drawer_info, onTap: () {
                      adService.checkCounterAd();
                      Get.to(InfoScreenView());
                    }),
                    drawerItem(title: 'Share App', image: ConstantsImage.drawer_share, onTap: () {
                      Share.share('check out my website https://example.com');
                    }),
                    drawerItem(title: 'Terms Of Service', image: ConstantsImage.drawer_terms, onTap: () {
                      adService.checkCounterAd();
                      Get.to(WebScreenView(), arguments: 'https://flutter.dev');
                    }),
                    drawerItem(title: 'Privacy Policy', image: ConstantsImage.drawer_privacy, onTap: () {
                      adService.checkCounterAd();
                      Get.to(WebScreenView(), arguments: 'https://www.google.com/');
                    }),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }


  static drawerItem({required String image, required String title, required Function() onTap}) {
    return Column(
      children: [
        SizedBox(height: 11.sp),
        InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(left: 25),
            height: 60,
            child: Row(
              children: [
                Image.asset(image, height: 26.5.sp, width: 26.5.sp),
                VerticalDivider(indent: 15.sp, endIndent: 15.sp, thickness: 1.2, color: Colors.black54, width: 30.sp),
                Text(title, style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis,)
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }

}