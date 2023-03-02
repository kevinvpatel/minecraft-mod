import 'dart:convert';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/json_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/widget_constants.dart';
import 'package:minecraft_mod_flutter/app/data/data_model.dart';
import 'package:http/http.dart' as http;
import 'package:minecraft_mod_flutter/app/data/internet_check_service.dart';
import 'package:minecraft_mod_flutter/app/modules/detail_screen/views/detail_screen_view.dart';
import 'package:minecraft_mod_flutter/app/modules/list_screen/views/list_screen_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  List<String> categoryChips = ['Mods', 'Textures', 'Skins', 'Maps', 'Seeds', 'Shaders'];
  List<String> categoryTags = ['mods', 'texture-packs', 'skins', 'maps', 'seeds', 'shaders'];
  List<List<Map<String, String>>> categoryData = [ConstantsJson.listmods, ConstantsJson.listtexture, ConstantsJson.listskin,
    ConstantsJson.listmap, ConstantsJson.listseed, ConstantsJson.listshader];
  List<Color> categoryColors = const [
    Color.fromRGBO(73, 177, 29, 1),
    Color.fromRGBO(255, 136, 45, 1),
    Color.fromRGBO(21, 184, 245, 1),
    Color.fromRGBO(235, 196, 0, 1),
    Color.fromRGBO(18, 56, 181, 1),
    Color.fromRGBO(139, 34, 230, 1)
  ];


  RxBool isSearchOn = false.obs;
  TextEditingController txtSearchController = TextEditingController();



  Future<List<Category>> getData({required String url, required String tag}) async {
    Data? data;
    int _page = 0;
    int listLength = 7;
    List<Category> lstCategory= [];
    try {
      tag == 'texture-packs' ? listLength = 8 : listLength = 7;
      while(lstCategory.length < listLength) {
        _page++;
        url = url.replaceAll('&page=1', '&page=$_page');
        http.Response response = await http.get(Uri.parse(url));
        if(response.statusCode == 200) {
          final result = json.decode(response.body);
          data = Data.fromJson(result, tag);

          data.category?.forEach((element) {
            if(lstCategory.length < listLength) {
              lstCategory.add(element);
            }
          });
        } else {
          print('data load Home Screen error Code -> ${response.statusCode}');
          print('data load Home Screen error -> ${response.reasonPhrase}');
        }
      }
    } catch(err) {
        print('data catch Home Screen error -> $err');
    }
    return lstCategory;
  }


  Widget categoryList({
    required double width,
    required String title,
    required String tag,
    required List<Map<String, String>> dataList,
  }) {
    print('get.route -> ${Get.currentRoute}');
    double boxHeight = 280;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: boxHeight,
      width: width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                GestureDetector(
                  onTap: () {
                    Get.to(const ListScreenView(), arguments: {'dataList' : dataList, 'ctgName' : tag});
                  },
                  child: const Text('View All', style: TextStyle(fontSize: 16, color: Colors.brown),)
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Category>>(
              // future: isSearchOn.value == true ? searchData(url: dataUrlList[0], tag: tag) : getData(url: dataUrlList[0], tag: tag),
              future: getData(url: dataList[0]['url']!, tag: tag),
              builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting) {
                  return ConstantsWidgets.progressBarAndroid();
                } else if(snapshot.connectionState == ConnectionState.none) {
                  return const Center(child: Text('Something Wrong'));
                } else {
                  if(snapshot.hasData) {
                    List<Category>? fetchedData = snapshot.data;

                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: fetchedData?.length,
                        itemBuilder: (context, index) {

                          final ctgName = tag.replaceAll('-', '_');
                          String imageUrl;
                          if(tag == 'skins') {
                            imageUrl = 'http://owlsup.ru/main_catalog/$ctgName/${fetchedData![index].id!}/skinIMG.png';
                          } else {
                            imageUrl = 'http://owlsup.ru/main_catalog/$ctgName/${fetchedData![index].id!}/screens/s0.jpg';
                          }

                          if(tag == 'texture-packs' && index == 1) {
                            return Container(
                              margin: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 10),
                              width: width * 0.43,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))]
                              ),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
                                  child: AdService.nativeAd(width: width, smallAd: true)
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                final data1 = json.encode(fetchedData[index]);
                                Get.to(const DetailScreenView(), arguments: {'dataList' : dataList, 'singleCategory': data1, 'ctgName' : ctgName});
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 10),
                                width: width * 0.43,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))]
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
                                        child: Hero(
                                          tag: fetchedData[index].id!,
                                          child: CachedNetworkImage(
                                            imageUrl: imageUrl,
                                            height: boxHeight * 0.55,
                                            fit: BoxFit.fill,
                                            errorWidget: (ctx, url, err) => const Icon(Icons.error, color: Colors.red),
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
                                          Divider(thickness: 1, color: Colors.grey.shade500,),
                                          Text(fetchedData[index].title!, style: const TextStyle(fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Image.asset(ConstantsImage.heart, height: 16),
                                                  const SizedBox(height: 3),
                                                  Text(ConstantsWidgets.k_m_b_generator(num: int.parse(fetchedData[index].likes!)), style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700))
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                children: [
                                                  Image.asset(ConstantsImage.eye, height: 18),
                                                  const SizedBox(height: 3),
                                                  Text(ConstantsWidgets.k_m_b_generator(num: int.parse(fetchedData[index].views!)), style: const TextStyle(fontSize: 10.5))
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                children: [
                                                  Image.asset(ConstantsImage.download, height: 17),
                                                  const SizedBox(height: 3),
                                                  Text(ConstantsWidgets.k_m_b_generator(num: int.parse(fetchedData[index].downloads!)), style: const TextStyle(fontSize: 10.5))
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
                        }
                    );
                  } else {
                    return const Center(child: Text('No Data Available'));
                  }
                }
              }
            )
          )
        ],
      ),
    );
  }


  @override
  void onInit() {
    super.onInit();
    InternetCheckService.listener;
  }


  void increment() => count.value++;
}
