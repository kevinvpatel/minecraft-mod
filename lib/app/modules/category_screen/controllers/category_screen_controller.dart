import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/json_constants.dart';
import 'package:minecraft_mod_flutter/main.dart';

class CategoryScreenController extends GetxController {
  //TODO: Implement CategoryScreenController



  List<String> lstCategoryTitle = ['MODS', 'TEXTURES', 'SKINS', 'MAPS', 'SEEDS', 'SHADERS'];
  List<String> lstCategoryTagName = ['mods', 'texture-packs', 'skins', 'maps', 'seeds', 'shaders'];
  List<List<Map<String, String>>> lstCategoryData = [
    ConstantsJson.listmods, ConstantsJson.listtexture, ConstantsJson.listskin, ConstantsJson.listmap, ConstantsJson.listseed, ConstantsJson.listshader
  ];
  List<String> lstCategoryImages = [
    ConstantsImage.event_ctg,
    ConstantsImage.textures_ctg,
    ConstantsImage.skins_ctg,
    ConstantsImage.maps_ctg,
    ConstantsImage.seeds_ctg,
    ConstantsImage.add_ons_ctg,
  ];


  AdService adService = AdService();

  RxInt counter = 1.obs;
  checkCounterAd({required BuildContext context}) {
    print('counterr -> $counter');
    if(counter.value == configData.value['counter']) {

      // update();
      counter.value = 1;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Row(
                children: const [
                  CircularProgressIndicator(),
                  Spacer(),
                  Text('Please Wait...  Counter'),
                  Spacer(),
                ],
              ),
            );
          }
      );
      // Get.dialog(AlertDialog(
      //   content: Row(
      //     children: const [
      //       CircularProgressIndicator(),
      //       Spacer(),
      //       Text('Please Wait...  Counter'),
      //       Spacer(),
      //     ],
      //   ),
      // ));
      Future.delayed(const Duration(milliseconds: 1000), () {
        adService.interstitialAd(onAdFailedToLoad: (error) {
          adService.interstitialAdMob = null;
          adService.interstitialAd(
              adId: configData.value['interstitial-admob'],
              onAdFailedToLoad: (LoadAdError) {
                counter.value = 1;
                Future.delayed(const Duration(milliseconds: 1000), () => Get.back());
              }
          );
        });
      });

    } else {
      counter.value++;
    }
  }


  RxInt backCounter = 1.obs;
  checkBackCounterAd() {
    print('backCounter -> $backCounter');
    if(backCounter.value == configData.value['back_counter']) {
      backCounter.value = 1;
      Get.dialog(AlertDialog(
        content: Row(
          children: const [
            CircularProgressIndicator(),
            Spacer(),
            Text('Please Wait...  Back_counter'),
            Spacer(),
          ],
        ),
      ));
      Future.delayed(const Duration(milliseconds: 1000), () {
        adService.interstitialAd(onAdFailedToLoad: (error) {
          adService.interstitialAdMob = null;
          adService.interstitialAd(
              adId: configData.value['interstitial-admob'],
              onAdFailedToLoad: (LoadAdError ) {
                backCounter.value = 1;
                Future.delayed(const Duration(milliseconds: 1000), () => Get.back());
              },
              isBack: true
          );
        }, isBack: true);
      });
    } else {
      backCounter.value++;
    }
  }



  @override
  void onInit() {
    super.onInit();
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
