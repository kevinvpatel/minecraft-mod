import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:minecraft_mod_flutter/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

RxInt counterInterstitalAd = 1.obs;
RxInt backCounterInterstitalAd = 1.obs;

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


  ///INTERSTITIAL AD
  InterstitialAd? interstitialAdMob;
  Future interstitialAd({String? adId, required Function(LoadAdError) onAdFailedToLoad, bool isBack = false}) async {
    print('interstitialAd LOAD -> ${adId}');
    print('interstitialAd Get.currentRoute -> ${Get.currentRoute}');
    print('interstitialAd Get.previousRoute -> ${Get.previousRoute}');
    print('isBack -> ${isBack}');

    if(configData.value[isBack ? Get.previousRoute : Get.currentRoute]['interstitial-type'] == 'admob') {
      print('interstitialAd LOAD 22 -> ${adId}');
      await InterstitialAd.load(
          adUnitId: adId ?? configData.value[isBack ? Get.previousRoute : Get.currentRoute]['interstitial-admob'],
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
            interstitialAdMob = ad;
            print('interstitialAd LOAD 33 -> ${adId}');
            ad.show();
            if (interstitialAdMob == null) {
              print('attempt to show InterstitialAd before loaded');
            }
            Future.delayed(const Duration(milliseconds: 1000), () {
              print('ad popup close');
              Get.back();
            });
          }, onAdFailedToLoad: onAdFailedToLoad
          )
      ).catchError((err) => print('InterstitialAd err -> $err'));
    } else if(configData.value[isBack ? Get.previousRoute : Get.currentRoute]['interstitial-type'] == 'url') {

      if(await canLaunchUrl(Uri.parse(configData.value[isBack ? Get.previousRoute : Get.currentRoute]['link']))) {
        await launchUrl(Uri.parse(configData.value[isBack ? Get.previousRoute : Get.currentRoute]['link']));
      } else {
        Fluttertoast.showToast(msg: 'Could not launch url: ${configData.value[isBack ? Get.previousRoute : Get.currentRoute]['link']}');
      }
      Future.delayed(const Duration(milliseconds: 1000), () => Get.back());

    } else {
      print('interstitialAd facebook -> ${configData.value['interstitial-facebook']}');
      FacebookInterstitialAd.loadInterstitialAd(
          placementId: configData.value['interstitial-facebook'],
          listener: (result, value) {
            if(result == InterstitialAdResult.LOADED) {
              FacebookInterstitialAd.showInterstitialAd(delay: 2000).then((value) =>
                  Future.delayed(const Duration(milliseconds: 1000), () => Get.back()));
            }
          }
      );
    }
  }


  checkCounterAd() {
    print('counterr -> $counterInterstitalAd');
    Future.delayed(Duration(milliseconds: 1200), () {
      if(counterInterstitalAd.value == configData.value['counter']) {
        counterInterstitalAd.value = 1;
        Get.dialog(
            barrierDismissible: false,
            WillPopScope(
              onWillPop: () => Future.value(false),
              child: AlertDialog(
                content: Row(
                  children: [
                    SizedBox(
                        height: 25.sp,
                        width: 25.sp,
                        child: const CircularProgressIndicator(color: Colors.brown)
                    ),
                    const Spacer(),
                    Text('Please Wait...', style: TextStyle(fontSize: 16.5.sp)),
                    const Spacer(),
                  ],
                ),
              ),
            )
        );
        Future.delayed(const Duration(milliseconds: 1000), () {
          interstitialAd(onAdFailedToLoad: (error) {
            interstitialAdMob = null;
            interstitialAd(
                adId: configData.value['interstitial-admob'],
                onAdFailedToLoad: (LoadAdError) {
                  counterInterstitalAd.value = 1;
                  Future.delayed(const Duration(milliseconds: 1000), () => Get.back());
                }
            );
          });
        });
      } else {
        counterInterstitalAd.value++;
      }
    });
  }


  checkBackCounterAd() {
    print('backCounter -> $backCounterInterstitalAd');
    Future.delayed(Duration(milliseconds: 1200), () {
      if(backCounterInterstitalAd.value == configData.value['back_counter']) {
        backCounterInterstitalAd.value = 1;
        Get.dialog(
            barrierDismissible: false,
            WillPopScope(
              onWillPop: () => Future.value(false),
              child: AlertDialog(
                content: Row(
                  children: [
                    SizedBox(
                        height: 25.sp,
                        width: 25.sp,
                        child: const CircularProgressIndicator(color: Colors.brown)
                    ),
                    const Spacer(),
                    Text('Please Wait...', style: TextStyle(fontSize: 16.5.sp)),
                    const Spacer(),
                  ],
                ),
              ),
            )
        );
        Future.delayed(const Duration(milliseconds: 1000), () {
          interstitialAd(
              isBack: Get.currentRoute == '/HomeView' ? false : true,
              onAdFailedToLoad: (error) {
                interstitialAdMob = null;
                interstitialAd(
                  isBack: Get.currentRoute == '/HomeView' ? false : true,
                  adId: configData.value['interstitial-admob'],
                  onAdFailedToLoad: (LoadAdError ) {
                    backCounterInterstitalAd.value = 1;
                    Future.delayed(const Duration(milliseconds: 1000), () => Get.back());
                  },
                );
              });
        });
      } else {
        backCounterInterstitalAd.value++;
      }
    });
  }

}