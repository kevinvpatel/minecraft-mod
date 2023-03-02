import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';

class InfoScreenController extends GetxController {
  //TODO: Implement InfoScreenController

  final count = 0.obs;

  List<String> lstTitle = ['1. Download', '2. Open', '3. Choose Minecraft', '4. Allow Minecraft access', '5. Success'];
  List<String> lstImages = [ConstantsImage.download_info, ConstantsImage.open_info, ConstantsImage.choose_info, ConstantsImage.allow_info, ConstantsImage.success_info];


  infoTiles({required double width}) {
    return Column(
      children: List.generate(lstTitle.length, (index) {
        return Column(
          children: [
            Container(
              height: 45,
              // color: Colors.green,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20, top: 20, bottom: 5),
              child: Text(lstTitle[index], style: TextStyle(color: Colors.brown.shade600, fontSize: 22, fontWeight: FontWeight.w600),),
            ),
            Image.asset(lstImages[index], width: width * 0.82),
            SizedBox(height: 20)
          ],
        );
      }),
    );
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

  void increment() => count.value++;
}
