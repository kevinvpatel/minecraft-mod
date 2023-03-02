import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/constants/color_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/modules/list_screen/controllers/list_screen_controller.dart';

class ListWidgets {

  static PreferredSizeWidget appBar({required double width, required ListScreenController controller}) {
    return AppBar(
      leadingWidth: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 20,
            child: TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: (){Get.back();},
                child: Image.asset(ConstantsImage.back, height: 22)
            ),
          ),
          SizedBox(
            height: 35,
            width: width * 0.55,
            child: TextField(
              controller: controller.searchController,
              cursorColor: Colors.brown,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 15),
                  filled: true,
                  fillColor: ConstantsColor.orange100,
                  hintStyle: TextStyle(fontSize: 17, color: Colors.brown),
                  hintText: 'Search here...',
                  suffixIcon: Container(width: 20, margin: EdgeInsets.only(right: 10), child: Image.asset(ConstantsImage.search)),
                  // suffixIcon: Obx(() {
                  //   return TextButton(
                  //       style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                  //       onPressed: controller.isSearchOn.value == true ? (){
                  //         controller.isSearchOn.value = false;
                  //         controller.txtSearchController.clear();
                  //       } : null,
                  //       child: controller.isSearchOn.value == true ? Icon(Icons.clear, color: Colors.brown) : Image.asset(ConstantsImage.search)
                  //   );
                  // }),
                  suffixIconConstraints: BoxConstraints(maxHeight: 40, maxWidth: 40),

              ),
              onTap: () {
                // controller.searchController.text.isEmpty ? controller.isSearchOn.value = false : controller.isSearchOn.value = true;
              },
              onChanged: (text) {
                // controller.searchController.text = text;
                // controller.isSearchOn.value = true;
              },
            ),
          )
        ],
      ),
      backgroundColor: ConstantsColor.orange50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
    );
  }

}