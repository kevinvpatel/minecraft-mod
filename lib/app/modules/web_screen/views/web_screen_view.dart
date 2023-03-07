import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/web_screen_controller.dart';

class WebScreenView extends GetView<WebScreenController> {
  const WebScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebScreenView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'WebScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
