import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minecraft_mod_flutter/app/data/constants/color_constants.dart';
import 'package:minecraft_mod_flutter/app/modules/category_screen/views/category_widgets.dart';
import 'package:minecraft_mod_flutter/app/modules/list_screen/views/list_screen_view.dart';

import '../controllers/category_screen_controller.dart';

class CategoryScreenView extends GetView<CategoryScreenController> {
  const CategoryScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    CategoryScreenController controller = Get.put(CategoryScreenController());


    return Scaffold(
      backgroundColor: ConstantsColor.orange50,
      appBar: CategoryWidgets.appBar(width: width),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 40),
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemCount: controller.lstCategoryTitle.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(const ListScreenView(), arguments: {'dataList' : controller.lstCategoryData[index], 'ctgName' : controller.lstCategoryTagName[index]});
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 20),
                padding: EdgeInsets.only(bottom: 15),
                width: width * 0.9,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.primaries[index],
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(image: AssetImage(controller.lstCategoryImages[index]), fit: BoxFit.cover),
                ),
                alignment: Alignment.bottomCenter,
                child: Stack(
                  // alignment: Alignment.bottomCenter,
                  children: [
                    Text(controller.lstCategoryTitle[index],
                      style: GoogleFonts.pressStart2p(
                          fontSize: 28.5,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Color.fromRGBO(123, 136, 0, 1)
                      ),
                    ),
                    Text(controller.lstCategoryTitle[index],
                      style: GoogleFonts.pressStart2p(
                          fontSize: 28,
                          // color: Color.fromRGBO(254, 254, 125, 1),
                          foreground: Paint()
                            ..shader = LinearGradient(colors: <Color>[Color.fromRGBO(254, 254, 125, 1), Color.fromRGBO(254, 254, 13, 1)]).createShader(Rect.fromLTRB(0.0, 0.0, 200.0, 70.0))
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
