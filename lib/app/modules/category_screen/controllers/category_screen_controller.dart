import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft_mod_flutter/app/data/adServices.dart';
import 'package:minecraft_mod_flutter/app/data/constants/image_constants.dart';
import 'package:minecraft_mod_flutter/app/data/constants/json_constants.dart';
import 'package:minecraft_mod_flutter/main.dart';



class CategoryScreenController extends GetxController {
  //TODO: Implement CategoryScreenController



  List<String> lstCategoryTitle = ['MODS', 'TEXTURES', 'SKINS', 'MAPS', 'SEEDS', 'SHADERS'];
  List<String> lstCategoryTagName = ['mods', 'texture-packs', 'skins', 'maps', 'seeds', 'shaders'];
  List<List<Map<String, String>>> lstCategoryData = [
    ConstantsJson.listmods, ConstantsJson.listtexture, ConstantsJson.listskin, ConstantsJson.listmap, ConstantsJson.listseed, ConstantsJson.listshader
  ];
  List<String> lstCategoryImages = [
    ConstantsImage.event_ctg,
    ConstantsImage.textures_ctg,
    ConstantsImage.skins_ctg,
    ConstantsImage.maps_ctg,
    ConstantsImage.seeds_ctg,
    ConstantsImage.add_ons_ctg,
  ];


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
