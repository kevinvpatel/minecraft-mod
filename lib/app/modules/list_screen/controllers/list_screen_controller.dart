import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/widget_constants.dart';
import 'package:minecraft_mod_flutter/app/data/data_model.dart';
import 'package:http/http.dart' as http;
import 'package:minecraft_mod_flutter/app/modules/category_screen/controllers/category_screen_controller.dart';
import 'package:minecraft_mod_flutter/app/modules/detail_screen/views/detail_screen_view.dart';
import 'package:minecraft_mod_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class ListScreenController extends GetxController {
  //TODO: Implement ListScreenController

  AdService adService = AdService();

  ///drop down
  List<String> lstSortDropdown = ['Sort Default', 'Newest', 'Top Download'];
  RxString? selectedSortValue = 'Sort Default'.obs;
  RxList<Map<String, String>> lstMapCategoryDropdown = <Map<String, String>>[].obs;
  RxList<String> lstCategoryDropdown = <String>[].obs;
  RxString? selectedCategoryValue = ''.obs;


  late RxList<Category> lstCategory;
  late RxList<Category> lstSearchedCategory;
  RxInt pageNumber = 1.obs;
  RxInt searchedPageNumber = 1.obs;
  RxBool isLoading = false.obs;


  TextEditingController searchController = TextEditingController();
  RxBool isSearchOn = false.obs;


  ///Sort Default = likes
  ///Newest = dates
  ///Top Download = downloads
  RxString sort = 'likes'.obs;

  Future<List<Category>> getData({required String url, required String tag}) async {
    Data? data;
    try {
      ///Change Page Number
      final pageNumberUrl = url.substring(0, url.length-1);
      ///Change Sorting Order
      final sortUrl = pageNumberUrl.replaceAll('downloads', sort.value).replaceAll('likes', sort.value).replaceAll('dates', sort.value).replaceAll('date', sort.value);

      http.Response response = await http.get(Uri.parse(sortUrl + pageNumber.value.toString()));
      if(response.statusCode == 200) {
        final result = json.decode(response.body);
        if(result['error'] == null) {
          data = Data.fromJson(result, tag);

          data.category!.forEach((element) {
            if(!lstCategory.value.contains(element)) {
              lstCategory.value.add(element);
              lstCategory.refresh();
            }
          });
          // lstCategory.addAll(data.category!);
        }
        isLoading.value = false;
      } else {
        print('data load error Code -> ${response.statusCode}');
        print('data load error -> ${response.reasonPhrase}');
      }
    } catch(err) {
      print('data catch error -> ${err}');
    }
    return lstCategory.value;
  }


  Future<List<Category>> searchData({required String url, required String tag}) async {
    Data? data;
    try {
      ///Change Page Number
      final pageNumberUrl = url.substring(0, url.length-1);
      // print('pageNumberUrl -> $pageNumberUrl');
      ///Change Sorting Order
      final sortUrl = pageNumberUrl.replaceAll('downloads', sort.value).replaceAll('likes', sort.value).replaceAll('dates', sort.value).replaceAll('date', sort.value);
      // print('sortUrl -> $sortUrl');
      // print('isSearchOn.value -> ${isSearchOn.value}');

      ///Getting Response From Url
      final startIndex = sortUrl.indexOf('&search-phrase=');
      final endIndex = sortUrl.indexOf('&category=');
      String searchedUrl = sortUrl.replaceRange(startIndex, endIndex, '&search-phrase=${searchController.text}');
      http.Response response = await http.get(Uri.parse(searchedUrl + searchedPageNumber.value.toString()));
      print(' ');
      print('searchData searchedUrl -> ${searchedUrl + searchedPageNumber.value.toString()}');

      if(response.statusCode == 200) {
        final result = json.decode(response.body);
          print('result  1  -> ${result}');
        if(result['error'] == null) {
          print('result[error] -> ${result['error']}');
          data = Data.fromJson(result, tag);

          print('result[error] -> ${result['error']}');
          data.category!.forEach((element) {
            print('searchData.title -> ${element.title}');
            print('searchData.title contain -> ${lstSearchedCategory.value.contains(element)}');
            if(!lstSearchedCategory.value.contains(element)) {
              lstSearchedCategory.value.add(element);
            }
          });
          lstSearchedCategory.refresh();
        }
        isLoading.value = false;
        print('lstSearchedCategory.length -> ${lstSearchedCategory.value.length}');
      } else {
        print('data load error Code -> ${response.statusCode}');
        print('data load error -> ${response.reasonPhrase}');
      }
    } catch(err) {
      print('data catch error -> ${err}');
    }
    return lstSearchedCategory.value;
  }


  ScrollController scrollController = ScrollController();

  Widget gridCell({required double width, required Category category}) {
    final ctgName = Get.arguments['ctgName'].replaceAll('-', '_');
    String imageUrl = '';
    if(category.id != null) {
      if (Get.arguments['ctgName'] == 'skins') {
        imageUrl =
        'http://owlsup.ru/main_catalog/${ctgName}/${category.id}/skinIMG.png';
      } else {
        imageUrl =
        'http://owlsup.ru/main_catalog/${ctgName}/${category.id}/screens/s0.jpg';
      }
    }
    return InkWell(
      onTap: () {
        final data = json.encode(category);
        Get.to(const DetailScreenView(), arguments: {'dataList' : Get.arguments['dataList'], 'singleCategory': data, 'ctgName' : ctgName});
        adService.checkCounterAd();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 12.sp),
        width: width * 0.43,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(18), topLeft: Radius.circular(18)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2, offset: Offset(0, 4))]
        ),
        child: Column(
          children: [
            Container(
              width: width * 0.43,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
                // child: Image.network(imageUrl, height: boxHeight * 0.55, fit: BoxFit.fill),
                child: Hero(
                  tag: category.id!,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 50.sp,
                    fit: BoxFit.fill,
                    errorWidget: (ctx, url, err) => Center(child: Text('image \n not available', style: TextStyle(fontSize: 15.5.sp), textAlign: TextAlign.center,)),
                    progressIndicatorBuilder: (ctx, url, progress) => ConstantsWidgets.progressBariOS(),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(thickness: 1, color: Colors.grey.shade500, height: 16.sp),
                  Text(category.title!, style: TextStyle(fontSize: 16.5.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 8.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(ConstantsImage.heart, height: 15.5.sp),
                          const SizedBox(height: 3),
                          Text(ConstantsWidgets.k_m_b_generator(num: int.parse(category.likes!)),
                              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700))
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Image.asset(ConstantsImage.eye, height: 16.sp),
                          const SizedBox(height: 3),
                          Text(ConstantsWidgets.k_m_b_generator(num: int.parse(category.views!)), style: TextStyle(fontSize: 13.5.sp))
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Image.asset(ConstantsImage.download, height: 15.5.sp),
                          const SizedBox(height: 3),
                          Text(ConstantsWidgets.k_m_b_generator(num: int.parse(category.downloads!)), style: TextStyle(fontSize: 13.5.sp))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget gridView({required double width, required double height}) {
    return Expanded(
        child: Obx(() {
          return Column(
            children: [
              Expanded(
                child: lstCategory.value.isNotEmpty
                  ? ListView.separated(
                    controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: width * 0.05, bottom: width * 0.13),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: isSearchOn.value ? lstSearchedCategory.value.length : lstCategory.value.length,
                      addAutomaticKeepAlives: true,
                      separatorBuilder: (context, index) => (index+1) % 6 == 0
                        ///NativeAd Container
                          ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        width: width * 0.9,
                        height: width * 0.5,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(251, 240, 209, 1),
                            // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2, offset: Offset(0, 4))]
                        ),
                        alignment: Alignment.center,
                        child: AdService.nativeAd(width: width, smallAd: false),
                      ) : SizedBox(),

                      itemBuilder: (context, index) {
                        if(index.isEven) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ///Left Cell
                              gridCell(category: isSearchOn.value ? lstSearchedCategory.value[index] : lstCategory.value[index], width: width),

                              ///Right Cell
                              isSearchOn.value ? lstSearchedCategory.value.length < (index +2)
                                  ? Container(width: width * 0.43)
                                  : gridCell(category: lstSearchedCategory.value[index + 1], width: width)

                                  : lstCategory.value.length < (index +2)
                                  ? Container(width: width * 0.43)
                                  : gridCell(category: lstCategory.value[index + 1], width: width)
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }

                  )
                  : ConstantsWidgets.progressBarAndroid(),
              ),
              isLoading.value ? Container(
                height: 40,
                width: width,
                child: CupertinoActivityIndicator(),
              ) : SizedBox.shrink()
            ],
          );
        })
    );
  }


  @override
  void onInit() {
    super.onInit();
    lstCategory = <Category>[].obs;
    lstSearchedCategory = <Category>[].obs;

    getData(url: Get.arguments['dataList'][0]['url'], tag: Get.arguments['ctgName']);

    searchController.addListener(() {

      print('searchController.text -> ${searchController.text}');
      if(searchController.text.isEmpty) {
        searchedPageNumber.value = 1;
        lstSearchedCategory.value.clear();
        isSearchOn.value = false;
      } else {
        isSearchOn.value = true;
        searchedPageNumber.value = 1;
        lstSearchedCategory.value.clear();
        searchData(url: Get.arguments['dataList'][0]['url'], tag: Get.arguments['ctgName']);
      }
    });

    scrollController.addListener(() {
      print('scrollController called @@');
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        isLoading.value = true;
        isSearchOn.value == true
            ? searchedPageNumber.value++
            : pageNumber.value++;
        isSearchOn.value == true
            ? searchData(url: Get.arguments['dataList'][0]['url'], tag: Get.arguments['ctgName'])
            : getData(url: Get.arguments['dataList'][0]['url'], tag: Get.arguments['ctgName']);
      } else {
        isLoading.value = false;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    Get.arguments['dataList'].forEach((element) {
      lstCategoryDropdown.value.add(element['title']);
      lstMapCategoryDropdown.value.add(element);
    });
    selectedCategoryValue?.value = Get.arguments['dataList'][0]['title'];
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

}
