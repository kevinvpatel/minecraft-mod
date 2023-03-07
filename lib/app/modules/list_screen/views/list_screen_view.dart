import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:minecraft_mod_flutter/app/data/constants/color_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/modules/list_screen/views/list_widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controllers/list_screen_controller.dart';

class ListScreenView extends GetView<ListScreenController> {
  const ListScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ListScreenController controller = Get.put(ListScreenController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ConstantsColor.orange50,
      appBar: ListWidgets.appBar(width: width, controller: controller),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(height: 15),
            ///TITLE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(Get.arguments['ctgName'].toString().capitalizeFirst!.split('-')[0], style: TextStyle(fontSize: 21.sp, color: Colors.brown, fontWeight: FontWeight.w600),),
                  Spacer(),
                  Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton2(
                        buttonSplashColor: Colors.transparent,
                        buttonHighlightColor: Colors.transparent,
                        buttonHeight: 35,
                        dropdownWidth: width * 0.5,
                        customButton: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: width * 0.5,
                              alignment: Alignment.centerRight,
                              child: Text(controller.selectedCategoryValue!.value,
                                style: TextStyle(fontSize: 19.sp, color: Colors.brown, fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis, maxLines: 1),
                            ),
                            SizedBox(width: 15),
                            Image.asset(ConstantsImage.oneSideMenu, height: 21.sp)
                          ],
                        ),
                        dropdownDecoration: BoxDecoration(
                            color: Color.fromRGBO(251, 240, 209, 1),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 18, spreadRadius: 2, offset: Offset(0, 4))]
                        ),
                        buttonDecoration: BoxDecoration(color: Color.fromRGBO(251, 240, 209, 1)),
                        alignment: Alignment.center,
                        items: controller.lstCategoryDropdown.value.map((item) {
                          return DropdownMenuItem(
                              value: item,
                              child: Text(item, style: TextStyle(color: Colors.brown))
                          );
                        }).toList(),
                        // iconSize: 0,
                        value: controller.selectedCategoryValue?.value,
                        onChanged: (val) {
                          controller.selectedCategoryValue?.value = val as String;
                          controller.lstMapCategoryDropdown.forEach((element) {
                            if(element['title'] == val.toString()) {
                              controller.getData(url: element['url']!, tag: Get.arguments['ctgName']);
                            }
                          });

                          controller.lstCategory.clear();
                          controller.update();

                        }
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(height: 12),
            ///DropDownMenu
            Container(
              decoration: const BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0, offset: Offset(0, 4))]
              ),
              child: Row(
                children: [
                  Container(
                      height: 35,
                      width: width * 0.5,
                      alignment: Alignment.center,
                      color: const Color.fromRGBO(255, 235, 180, 1),
                      child: Text('All Type', style: TextStyle(color: Colors.brown, fontSize: 17.sp),)
                  ),
                  Obx(() =>
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonHeight: 35,
                          buttonWidth: width * 0.5,
                          buttonPadding: const EdgeInsets.only(right: 20, left: 60),
                          isExpanded: true,
                          dropdownDecoration: BoxDecoration(
                            color: const Color.fromRGBO(251, 240, 209, 1),
                            borderRadius: BorderRadius.circular(6),
                              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 18, spreadRadius: 2, offset: Offset(0, 4))]
                          ),
                          buttonDecoration: const BoxDecoration(color: Color.fromRGBO(251, 240, 209, 1)),
                          alignment: Alignment.center,
                          items: controller.lstSortDropdown.map((item) =>
                              DropdownMenuItem(
                                  value: item,
                                  child: Text(item, style: TextStyle(color: Colors.brown, fontSize: 17.sp),)
                              )
                          ).toList(),
                          value: controller.selectedSortValue?.value,
                          onChanged: (val) {
                            controller.selectedSortValue?.value = val as String;
                            ///Sort Default = like
                            ///Newest = date
                            ///Top Download = download
                            if(val.toString() == 'Sort Default') {
                              controller.sort.value = 'likes';
                            } else if(val.toString() == 'Newest') {
                              controller.sort.value = 'dates';
                            } else {
                              controller.sort.value = 'downloads';
                            }
                            controller.lstCategory.clear();
                            controller.getData(url: Get.arguments['dataList'][0]['url'], tag: Get.arguments['ctgName']);
                            controller.update();
                          },
                        ),
                      ),
                  )
                ],
              ),
            ),
            controller.gridView(width: width, height: height),
          ],
        ),
      ),
      bottomNavigationBar: AdService.bannerAd(width: width),
    );
  }
}
