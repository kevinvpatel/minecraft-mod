import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:minecraft_mod_flutter/app/modules/web_screen/views/web_widget.dart';

import '../controllers/web_screen_controller.dart';

class WebScreenView extends GetView<WebScreenController> {
  const WebScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    AdService adService = AdService();
    WebScreenController webScreenController = Get.put(WebScreenController());

    return Scaffold(
      appBar: WebWidget.appBar(width: width, adService: adService),
      body: Builder(builder: (BuildContext context) {
        return WebViewWidget(
          // initialUrl: 'https://flutter.dev/',
          // javascriptMode: JavascriptMode.unrestricted,
          // gestureNavigationEnabled: true,
          // backgroundColor: const Color(0x00000000),
          controller: webScreenController.controller,
        );
      }),
    );
  }
}
