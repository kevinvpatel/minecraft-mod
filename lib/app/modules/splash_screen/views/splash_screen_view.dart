import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import '../controllers/splash_screen_controller.dart';


class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: const Color.fromRGBO(255, 250, 235, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ConstantsImage.LOGO1080, width: width * 0.64),
            SizedBox(height: 40),
            const Text('Mods For Minecraft PE', style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
