import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:minecraft_mod_flutter/app/data/constants/color_constants.dart';
import 'package:minecraft_mod_flutter/app/modules/info_screen/views/info_widgets.dart';

import '../controllers/info_screen_controller.dart';

class InfoScreenView extends GetView<InfoScreenController> {
  const InfoScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    InfoScreenController controller = Get.put(InfoScreenController());

    return Scaffold(
      backgroundColor: ConstantsColor.orange50,
      appBar: InfoWidgets.appBar(width: width),
      body: Container(
        color: ConstantsColor.orange50,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: controller.infoTiles(width: width),
        ),
      ),
      bottomNavigationBar: AdService.bannerAd(width: width),
    );
  }
}
