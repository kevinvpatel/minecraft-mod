import 'dart:convert';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/widget_constants.dart';
import 'package:minecraft_mod_flutter/app/data/data_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';

class DetailScreenController extends GetxController {
  //TODO: Implement DetailScreenController

  final count = 0.obs;
  Rx<Category> categoryData = Category().obs;
  RxString imageUrl = ''.obs;
  ScrollController scrollController = ScrollController();

  Future<List<Category>> getSuggetionData({required String url, required String ctgName}) async {
    Data? data;
    int _page = 0;
    List<Category> lstCategory= [];
    try {
      final ctgTag = ctgName.replaceAll('_', '-');
      lstCategory.clear();
      while(lstCategory.length < 7) {
        _page++;
        url = url.replaceAll('&page=1', '&page=$_page');
        http.Response response = await http.get(Uri.parse(url));
        if(response.statusCode == 200) {
          final result = json.decode(response.body);
          data = Data.fromJson(result, ctgTag);

          data.category?.forEach((element) {
            if(lstCategory.length < 7) {
              lstCategory.add(element);
            }
          });
        } else {
          print('data load detail screen error Code -> ${response.statusCode}');
          print('data load detail screen error -> ${response.reasonPhrase}');
        }
      }
    } catch(err) {
      print('data catch detail screen error -> ${err}');
    }
    return lstCategory;
  }


  Widget imageList({required double width, required Category data}) {
    return data.screens != null ? Container(
      height: 46.sp,
      width: width,
      child: Column(
        children: [
          Container(
            width: width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text('IMAGES', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600), textAlign: TextAlign.start),
          ),
          Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: data.screens?.length,
                  itemBuilder: (context, index) {
                    final url = 'http://owlsup.ru/main_catalog/${Get.arguments['ctgName']}/${data.id}/screens/${data.screens?[index].url ?? ''}';

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(7)
                      ),
                      width: width * 0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CachedNetworkImage(
                          imageUrl: url,
                          width: width,
                          fit: BoxFit.fill,
                          errorWidget: (ctx, url, err) => Icon(Icons.error, color: Colors.red),
                          progressIndicatorBuilder: (ctx, url, progress) => ConstantsWidgets.progressBariOS(),
                        ),
                      ),
                    );
                  }
              )
          )
        ],
      ),
    ) : SizedBox.shrink();
  }

  Widget description({required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description :', style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w600)),
          const SizedBox(height: 25),
          Text(text, style: TextStyle(fontSize: 16.2.sp)),
        ],
      ),
    );
  }

  Widget suggetionList({required double width}) {
    // double boxHeight = 280;
    double boxHeight = 70.sp;
    final suggetionUrl = Get.arguments['dataList'][Get.arguments['dataList'].length - 1]['url'];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: boxHeight,
      width: width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              width: width,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Try Our Others', style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w600),),
            )
          ),
          Expanded(
              child: FutureBuilder<List<Category>>(
                  future: getSuggetionData(url: suggetionUrl, ctgName: Get.arguments['ctgName']),
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

                              final ctgName = Get.arguments['ctgName'].replaceAll('-', '_');
                              String image_url;
                              if(Get.arguments['ctgName'] == 'skins') {
                                image_url = 'http://owlsup.ru/main_catalog/${ctgName}/${fetchedData![index].id!}/skinIMG.png';
                              } else {
                                image_url = 'http://owlsup.ru/main_catalog/${ctgName}/${fetchedData![index].id!}/screens/s0.jpg';
                              }

                              return InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {

                                  final position = scrollController.position.minScrollExtent;
                                  scrollController.animateTo(position, duration: Duration(milliseconds: 900), curve: Curves.easeOut);

                                  categoryData.value = fetchedData[index];
                                  print('fetchedData[index] detailScreen -> ${fetchedData[index].title}');

                                  if(categoryData.value.id != null) {
                                    if (Get.arguments['ctgName'] == 'skins') {
                                      imageUrl.value =
                                      'http://owlsup.ru/main_catalog/${ctgName}/${categoryData.value.id}/skinIMG.png';
                                    } else {
                                      imageUrl.value =
                                      'http://owlsup.ru/main_catalog/${ctgName}/${categoryData.value.id}/screens/s0.jpg';
                                    }
                                  }

                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 13.5.sp),
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
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
                                          child: Hero(
                                            tag: fetchedData[index].id!,
                                            child: CachedNetworkImage(
                                              imageUrl: image_url,
                                              height: boxHeight * 0.58,
                                              // height: 52.5.sp,
                                              fit: BoxFit.fill,
                                              errorWidget: (ctx, url, err) => Icon(Icons.error, color: Colors.red),
                                              progressIndicatorBuilder: (ctx, url, progress) => ConstantsWidgets.progressBariOS(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.red,
                                        margin: EdgeInsets.only(left: 8, right: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Divider(thickness: 1, color: Colors.grey.shade500, height: 15.sp),
                                            Text(fetchedData[index].title!, style: TextStyle(fontSize: 16.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
                                            SizedBox(height: 8.sp),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Image.asset(ConstantsImage.heart, height: 16.sp),
                                                    SizedBox(height: 3),
                                                    Text(ConstantsWidgets.k_m_b_generator(num: int.parse(fetchedData[index].likes!)), style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700))
                                                  ],
                                                ),
                                                Spacer(),
                                                Column(
                                                  children: [
                                                    Image.asset(ConstantsImage.eye, height: 18.sp),
                                                    SizedBox(height: 3),
                                                    Text(ConstantsWidgets.k_m_b_generator(num: int.parse(fetchedData[index].views!)), style: TextStyle(fontSize: 13.sp))
                                                  ],
                                                ),
                                                Spacer(),
                                                Column(
                                                  children: [
                                                    Image.asset(ConstantsImage.download, height: 17.sp),
                                                    SizedBox(height: 3),
                                                    Text(ConstantsWidgets.k_m_b_generator(num: int.parse(fetchedData[index].downloads!)), style: TextStyle(fontSize: 13.sp))
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
                        );
                      } else {
                        return Center(child: Text('No Data Available'));
                      }
                    }
                  }
              )
          )
        ],
      ),
    );
  }


  RxList lstSideMenuTitle = ['Share App', 'Info', 'Privacy Policy'].obs;
  RxString? selectedSideMenu = 'Share App'.obs;
  RxList lstSideMenuIcon = [ConstantsImage.share, ConstantsImage.info, ConstantsImage.privacy_policy].obs;


  RxString progress = '0'.obs;
  RxBool isDownloaded = false.obs;
  RxBool isFileExist = false.obs;

  CancelToken cancelToken = CancelToken();


  Map<String, dynamic> manifest = {
    "format_version":1,
    "header": {
      "description":"Renegade",
      "name":"Renegade",
      "uuid":"64bd3680-acea-11ed-b911-b50f02e71012",
      "version":[0,0,1],
      "min_engine_version":[1,2,0]
    },
    "modules": [
      {
        "description":"Renegade",
        "type":"skin_pack",
        "uuid":"64bd5d90-acea-11ed-b911-b50f02e71012",
        "version":[0,0,1]
      }
    ]
  };

  Map<String, dynamic> skins = {
    "skins": [
      {
        "localization_name":"Renegade",
        "geometry":"geometry.humanoid.custom",
        "texture":"Renegade.png",
        "type":"free"
      }
    ],
    "serialize_name":"Renegade",
    "localization_name":"Renegade"
  };

  Future downloadSkin({
    required String imageName,
    required String title,
    required String url,
    required double width
  }) async {
    final uuid = Uuid();
    isDownloaded.value = false;
    print('url -> $url');
    print('imageName -> $imageName');
    print('title -> $title');
    String filePath = '';

    Directory? rootDir = await getExternalStorageDirectory();
    final zipPath = File('${rootDir!.path}/$title.mcpack');
    ///Create Folder
    Directory? dirPath = Directory('${rootDir.path}/$title');
    if(!await dirPath.exists()) {
      await dirPath.create();
    }
    ///Create imageFile
    filePath = '${dirPath.path}/$imageName';

    if(await File(zipPath.path).exists()) {
      OpenFile.open(zipPath.path, type: "*/*");
    } else {
      progressBar(width: width);

      ///Create jsonFile
      final File manifestFile = File('${dirPath.path}/manifest.json');
      if(!await manifestFile.exists()) {
        await manifestFile.create();
      }
      manifest['header']['description'] = title;
      manifest['header']['uuid'] = uuid.v1();
      manifest['header']['name'] = title;
      manifest['modules'][0]['description'] = title;
      manifest['modules'][0]['uuid'] = uuid.v1();
      String manifestString = json.encode(manifest);
      manifestFile.writeAsStringSync(manifestString);

      final File skinsFile = File('${dirPath.path}/skins.json');
      if(!await skinsFile.exists()) {
        await skinsFile.create();
      }
      skins['skins'][0]['localization_name'] = title;
      skins['serialize_name'] = title;
      skins['localization_name'] = title;
      skins['skins'][0]['texture'] = imageName;
      String skinsString = json.encode(skins);
      skinsFile.writeAsStringSync(skinsString);

      Dio dio = Dio();
      dio.download(url, filePath, onReceiveProgress: (rcv, total) => progress.value = ((rcv / total) * 100).toStringAsFixed(0), cancelToken: cancelToken, deleteOnError: true)
          .then((value) async {
        if (progress.value == '100') {
          Fluttertoast.showToast(msg: 'Downloaded to ${filePath}');
          Navigator.pop(Get.overlayContext!);
        }
        isFileExist.value = true;
        try{
          var encoder = ZipFileEncoder();
          encoder.create(zipPath.path);
          encoder.addDirectory(dirPath);
          encoder.close();
          OpenFile.open(zipPath.path, type: "*/*");
        } catch(err) {
          print('err zip -> $err');
        }
      });
    }

  }



  Future downloadFile({required String filename, required String url, required double width}) async {
    isDownloaded.value = false;
    print('url -> $url');
    print('filename -> $filename');
    String savePath = await getFilePath(fileName: filename);

    if(await File(savePath).exists()) {
      OpenFile.open(savePath, type: "*/*");
    } else {
      progressBar(width: width);

      Dio dio = Dio();
      dio.download(url, savePath, onReceiveProgress: (rcv, total) => progress.value = ((rcv / total) * 100).toStringAsFixed(0), cancelToken: cancelToken, deleteOnError: true)
          .then((value) {
        if (progress.value == '100') {
          Fluttertoast.showToast(msg: 'Downloaded to $savePath');
          Navigator.pop(Get.overlayContext!);
        }
        isFileExist.value = true;
        OpenFile.open(savePath, type: "*/*");
      });
    }

  }

  Future<String> getFilePath({required String fileName}) async {
    String path = '';
    Directory? dir = await getExternalStorageDirectory();
    path = '${dir?.path}/$fileName';
    return path;
  }

  progressBar({required double width}) {
    showDialog(
        context: Get.overlayContext!,
        builder: (context) {
          return WillPopScope(child: AlertDialog(
            contentPadding: EdgeInsets.only(top: 20, left: 20, right: 20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Please wait...', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                Obx(() => SizedBox(
                  height: 70,
                  width: width * 0.658,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: double.parse(progress.value) / 100,
                          color: Colors.brown,
                          backgroundColor: Colors.grey.shade300,
                          minHeight: 20,
                        ),
                      ),
                      Text('${progress.value} %'),
                    ],
                  ),
                )),
                Divider(),
                InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      cancelToken.cancel();
                      cancelToken = CancelToken();
                      Navigator.pop(Get.overlayContext!);
                    },
                    child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        height: 35,
                        width: width,
                        alignment: Alignment.center,
                        child: Text('Cancel', style: TextStyle(color: Colors.blue, fontSize: 18),)
                    )
                )
              ],
            ),
          ), onWillPop: () => Future.value(true),);
        }
    );
  }

  RxBool isCheckingFile = true.obs;
  checkFileExistance({required String filename}) async {
    if(await File(await getFilePath(fileName: filename)).exists()) {
      isFileExist.value = true;
    } else {
      isFileExist.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    categoryData = Category().obs;
  }

  RxString ctgName = ''.obs;

  @override
  Future<void> onReady() async {
    super.onReady();

    final data = json.decode(Get.arguments['singleCategory']);
    categoryData.value = Category.fromJson(data);
    print('onReady called first');

    final suggetionUrl = Get.arguments['dataList'][Get.arguments['dataList'].length - 1]['url'];
    getSuggetionData(url: suggetionUrl, ctgName: Get.arguments['ctgName']);
    print('suggetionUrl -> ${suggetionUrl}');


    ctgName.value = Get.arguments['ctgName'];
    if(categoryData.value.id != null) {
      if (Get.arguments['ctgName'] == 'skins') {
        imageUrl.value =
        'http://owlsup.ru/main_catalog/${ctgName.value}/${categoryData.value.id}/skinIMG.png';
      } else {
        imageUrl.value =
        'http://owlsup.ru/main_catalog/${ctgName.value}/${categoryData.value.id}/screens/s0.jpg';
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }


}
