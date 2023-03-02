import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:minecraft_mod_flutter/app/data/constants/color_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/widget_constants.dart';
import 'package:minecraft_mod_flutter/app/modules/detail_screen/views/detail_widgets.dart';
import '../controllers/detail_screen_controller.dart';


class DetailScreenView extends GetView<DetailScreenController> {
  const DetailScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DetailScreenController controller = Get.put(DetailScreenController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double imageHeight = 300;

    Future.delayed(const Duration(milliseconds: 1500), () {
      if(controller.categoryData.value.files?.first.url != null) {
        if(Get.arguments['ctgName'] == 'skins') {
          controller.checkFileExistance(filename: '${controller.categoryData.value.title!}.mcpack');
        } else {
          controller.checkFileExistance(filename: controller.categoryData.value.files!.first.url!);
        }
      }
      controller.isCheckingFile.value = false;
    });

    return Scaffold(
      backgroundColor: ConstantsColor.orange50,
      appBar: DetailWidgets.appBar(width: width, controller: controller),
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: controller.scrollController,
          child: Column(
            children: [
              ///Top Image BOX
              Container(
                height: imageHeight,
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))]
                ),
                child: Column(
                  children: [
                    Obx(() => Hero(
                      tag: controller.categoryData.value.id ?? '',
                      child: CachedNetworkImage(
                        imageUrl: controller.imageUrl.value,
                        height: imageHeight * 0.75,
                        width: width,
                        fit: BoxFit.fill,
                        errorWidget: (ctx, url, err) => const Icon(Icons.error, color: Colors.red),
                        progressIndicatorBuilder: (ctx, url, progress) => ConstantsWidgets.progressBariOS(),
                      ),
                    ),),
                    ///Icons
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0, top: 15),
                      child: Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DetailWidgets.imageIcon(data: controller.categoryData.value.likes ?? '0', width: width, image: ConstantsImage.heart, imageHeight: 25),
                            const Spacer(),
                            DetailWidgets.imageIcon(data: controller.categoryData.value.views ?? '0', width: width, image: ConstantsImage.eye, imageHeight: 26),
                            const Spacer(),
                            DetailWidgets.imageIcon(data: controller.categoryData.value.versions?.first.code ?? '0.0', width: width, image: ConstantsImage.version, imageHeight: 27, isVersion: true),
                            const Spacer(),
                            DetailWidgets.imageIcon(data: controller.categoryData.value.downloads ?? '0', width: width, image: ConstantsImage.download, imageHeight: 27),
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 25),
                width: width * 0.93,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Title
                    Obx(() => Text(controller.categoryData.value.title ?? '', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),),
                    const SizedBox(height: 12),

                    ///Tags
                    Wrap(
                      spacing: 10,
                      runSpacing: 5,
                      children: [
                        DetailWidgets.chipTag(
                            title: 'Tag', textColor: Colors.white, backgroundColor: Colors.blue.shade800,
                            sidePadding: 23, verticalPadding: 5, fontSize: 16.5
                        ),
                        SizedBox(width: width * 0.85),
                        Obx(() => Row(
                          children: List.generate(controller.categoryData.value.categories?.length ?? 0, (index) =>
                              DetailWidgets.chipTag(title: controller.categoryData.value.categories![index].name!, backgroundColor: Colors.grey.shade300)
                          ),
                        ))
                      ],
                    ),

                    const SizedBox(height: 20),
                    /// Download Button
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {

                            if(controller.ctgName.value == 'seeds') {

                              await Clipboard.setData(ClipboardData(text: controller.categoryData.value.key ?? ''));
                              Fluttertoast.showToast(msg: 'Key: ${controller.categoryData.value.key} copied sucessfully');

                            } else if (controller.ctgName.value == 'skins') {
                              String url = 'http://owlsup.ru/main_catalog/${controller.ctgName.value}/${controller.categoryData.value.id}/${controller.categoryData.value.files!.first.url}';
                              controller.downloadSkin(
                                  imageName: controller.categoryData.value.files!.first.url!,
                                  title: controller.categoryData.value.title!,
                                  url: url,
                                  width: width
                              );
                            } else {
                              String url = 'http://owlsup.ru/main_catalog/${controller.ctgName.value}/${controller.categoryData.value.id}/files/${controller.categoryData.value.files!.first.url}';

                              controller.downloadFile(
                                  filename: controller.categoryData.value.files!.first.url!,
                                  url: url,
                                  width: width
                              );
                            }



                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green
                          ),
                          child: Obx(() =>
                          controller.ctgName.value == 'seeds'
                              ? const Text('Copy', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),) : controller.isCheckingFile.value == true
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Checking File...', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                  Container(
                                    margin: const EdgeInsets.only(left: 30),
                                    height: 20,
                                    width: 20,
                                    child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                                  )
                                ],
                              )
                              : Text(controller.isFileExist.value ? 'Open' : 'Download', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),)
                          )
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              ///Advertise
              Container(
                height: 300,
                width: width,
                color: Colors.white,
                alignment: Alignment.center,
                child: AdService.nativeAd(width: width, smallAd: false),
              ),

              const SizedBox(height: 25),
              ///Image List
              Obx(() => controller.imageList(width: width, data: controller.categoryData.value),),

              controller.categoryData.value.description != null ? const SizedBox(height: 15) : const SizedBox.shrink(),
              Obx(() => controller.categoryData.value.description != null
                  ? controller.description(text: controller.categoryData.value.description!)
                  : const SizedBox.shrink()),



              const SizedBox(height: 25),
              ///Suggetion List
              controller.suggetionList(width: width),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AdService.bannerAd(width: width),
    );
  }
}
