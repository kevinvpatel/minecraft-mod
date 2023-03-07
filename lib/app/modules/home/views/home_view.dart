import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:minecraft_mod_flutter/app/data/constants/color_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/json_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/screen_resolution.dart';
import 'package:minecraft_mod_flutter/app/modules/category_screen/controllers/category_screen_controller.dart';
import 'package:minecraft_mod_flutter/app/modules/home/views/home_widgets.dart';
import 'package:minecraft_mod_flutter/app/modules/list_screen/views/list_screen_view.dart';
import 'package:minecraft_mod_flutter/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ScreenResolution.screenSize(context);
    AdService adService = AdService();

    return WillPopScope(
      onWillPop: () async {
        print('Get.currentRoute @@ -> ${Get.currentRoute}');
        if(Get.currentRoute == '/HomeView') {
          Get.dialog(AlertDialog(
            contentPadding: EdgeInsets.only(top: 20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Alert', style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w600, color: Colors.brown),),
                SizedBox(height: 15),
                Text('Do you want to exit the app?', style: TextStyle(fontSize: 17.sp, color: Colors.brown),),
                SizedBox(height: 25),
                Divider(height: 0,),
                SizedBox(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => SystemNavigator.pop(),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Yes', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600, color: Colors.blue),),
                        ),
                      ),
                      VerticalDivider(width: 2),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('No', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600, color: Colors.blue),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
        }
        // adService.checkBackCounterAd();
        return Future.value(false);
      },
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: ConstantsColor.orange50,
        drawer: HomeWidgets.drawer(width: width, adService: adService),
        appBar: HomeWidgets.appBar(width: width, controller: controller),
        body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ///Carousel Slider
                Column(
                  children: [
                    SizedBox(height: 12.sp),
                    CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 60.sp,
                          aspectRatio: 2,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.2,
                          viewportFraction: 0.75,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                        ),
                        itemCount: configData.value['banner-link'].length,
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                            // Image.network(configData.value['banner-link'][itemIndex], height: 200, width: width)
                        CachedNetworkImage(
                          // color: Colors.green,
                          imageUrl: configData.value['banner-link'][itemIndex],
                          height: 200, width: width,
                          progressIndicatorBuilder: (ctx, url, progress) =>  Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                              color: Colors.brown,
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                ///Category Chips
                Wrap(
                  spacing: 15.sp,
                  runSpacing: 2.sp,
                  alignment: WrapAlignment.start,
                  children: List.generate(controller.categoryChips.length, (index) =>
                      InkWell(
                        onTap: () {
                          Get.to(const ListScreenView(), arguments: {'dataList' : controller.categoryData[index], 'ctgName' : controller.categoryTags[index]});
                          adService.checkCounterAd();
                        },
                        child: Chip(
                          label: Text(controller.categoryChips[index], style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500, color: Colors.white)),
                          backgroundColor: controller.categoryColors[index],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 22),
                        ),
                      )
                  ),
                ),
                controller.categoryList(
                    width: width,
                    tag: 'mods',
                    title: 'Top Mods',
                    dataList: ConstantsJson.listmods,
                ),
                controller.categoryList(
                    width: width,
                    tag: 'texture-packs',
                    title: 'Top Textures',
                    dataList: ConstantsJson.listtexture,
                ),
                controller.categoryList(
                    width: width,
                    tag: 'skins',
                    title: 'Top Skins',
                    dataList: ConstantsJson.listskin,
                ),
                controller.categoryList(
                    width: width,
                    tag: 'maps',
                    title: 'Top Maps',
                    dataList: ConstantsJson.listmap,
                ),
                controller.categoryList(
                    width: width,
                    tag: 'seeds',
                    title: 'Top Seeds',
                    dataList: ConstantsJson.listseed,
                ),
                controller.categoryList(
                    width: width,
                    tag: 'shaders',
                    title: 'Top Shaders',
                    dataList: ConstantsJson.listshader,
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
        bottomNavigationBar: AdService.bannerAd(width: width),
      ),
    );
  }
}
