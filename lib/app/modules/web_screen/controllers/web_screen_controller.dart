import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreenController extends GetxController {
  //TODO: Implement WebScreenController

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(Get.arguments))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          // if (request.url.startsWith('https://www.youtube.com/')) {
          //   return NavigationDecision.prevent;
          // }
          return NavigationDecision.navigate;
        },
      ),
    );


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


}
