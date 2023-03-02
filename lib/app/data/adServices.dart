import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:minecraft_mod_flutter/main.dart';
import 'package:url_launcher/url_launcher.dart';

class AdService {

  ///NATIVE AD
  static Widget nativeAd({required double width, required bool smallAd}) {
    NativeAd? nativeMediumAd;
    RxBool isNativeAdLoaded = false.obs;
    if(configData.value[Get.currentRoute]['native-type'] == 'admob') {
      nativeMediumAd = NativeAd(
          adUnitId: configData.value[Get.currentRoute]['native-admob'],
          factoryId: smallAd ? 'listTile' : 'listTileMedium',   // listTile = small Ad , listTileMedium = medium Ad
          listener: NativeAdListener(
              onAdLoaded: (ad) {
                isNativeAdLoaded.value = true;
                print('Native Ad Loaded Successfully @@@@@@');
              },
              onAdFailedToLoad: (ad, error) {
                isNativeAdLoaded.value = false;
                print('Native Ad Loaded failed -> $error');
              }
          ),
          request: const AdRequest()
      );
      nativeMediumAd.load();
    }

    print('isNativeAdLoaded.value -> ${configData.value[Get.currentRoute]}');
    print('isNativeAdLoaded.value 22-> ${configData.value[Get.currentRoute]['native-type']}');
    return Obx(() {
      return configData.value[Get.currentRoute]['native-type'] == 'admob' ?
          ///GOOGLE AD
      isNativeAdLoaded.value == true
          ? AdWidget(ad: nativeMediumAd!)
          : const Center(child: CircularProgressIndicator())
          ///FACEBOOK AD
          : configData.value[Get.currentRoute]['native-type'] == 'facebook' ? FacebookNativeAd(
            placementId: configData.value['native-facebook'],
            adType: NativeAdType.NATIVE_AD,
            // bannerAdSize: NativeBannerAdSize.HEIGHT_120,
            width: smallAd ? width * 0.43 : width,
            backgroundColor: Colors.blue,
            titleColor: Colors.white,
            descriptionColor: Colors.white,
            buttonColor: Colors.deepPurple,
            buttonTitleColor: Colors.white,
            buttonBorderColor: Colors.white,
            listener: (result, value) {
              print("Native Banner Ad: $result --> $value");
            },
          ) : InkWell(
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              if(await canLaunchUrl(Uri.parse(configData.value[Get.currentRoute]['link']))){
                await launchUrl(Uri.parse(configData.value[Get.currentRoute]['link']));
              } else {
                Fluttertoast.showToast(msg: 'Could not launch url: ${configData.value[Get.currentRoute]['link']}');
              }
            },
            child: Container(
              // height: 300,
              width: smallAd ? width * 0.6 : width,
              child: Image.network(configData.value[Get.currentRoute]['image-link'], fit: BoxFit.cover),
            ),
        );
    });
  }


  ///BANNER AD
  static BannerAd? bannerAdAdMob;
  static RxBool isBannerAdLoaded = false.obs;

  static Widget bannerAd({required double width}) {
    print('Get.currentRoute -> ${Get.currentRoute}');
    print('data -> ${configData.value[Get.currentRoute]['banner-type']}');

    if(configData.value[Get.currentRoute]['banner-type'] == 'admob') {
      print('data 222-> ${configData.value[Get.currentRoute]['banner-type']}');
      bannerAdAdMob = BannerAd(
          size: AdSize.banner,
          // adUnitId: data['banner-admob'],
          adUnitId: 'ca-app-pub-3940256099942544/6300978111',
          listener: BannerAdListener(
            onAdLoaded: (ad) {
              isBannerAdLoaded.value = true;
              print('Banner Loaded Successfully @@@@@@');
            },
            onAdFailedToLoad: (ad, error) {
              isBannerAdLoaded.value = false;
              print('Banner -> ${ad.responseInfo?.adapterResponses}  &  Failed -> $error');
              // ad.dispose();
            },
          ),
          request: AdRequest()
      );
      bannerAdAdMob?.load();
    }

    return configData.value[Get.currentRoute]['banner-type'] == 'admob' ?
    Container(
      height: 50,
      width: width * 0.8,
      child: AdWidget(ad: bannerAdAdMob!),
    )
        : FacebookBannerAd(
      bannerSize: BannerSize.STANDARD,
      keepAlive: true,
      placementId: configData.value['banner-facebook'],
      listener: (result, value) {
        switch (result) {
          case BannerAdResult.ERROR:
            print("Error Facebook Banner Ad: $value");
            break;
          case BannerAdResult.LOADED:
            print("Loaded Banner Ad: $value");
            break;
          case BannerAdResult.CLICKED:
            print("Clicked Banner Ad: $value");
            break;
          case BannerAdResult.LOGGING_IMPRESSION:
            print("Logging Impression Banner Ad: $value");
            break;
        }
      },
    );
  }

}