import 'package:flutter/material.dart';

class ScreenResolution {
  static late MediaQueryData _mediaQuerydata;
  static late double screenWi;
  static late double screenHi;
  static double? horizontalScreenSize;
  static double? verticalScreenSize;

  static screenSize(BuildContext context) {
    _mediaQuerydata = MediaQuery.of(context);
    screenWi = _mediaQuerydata.size.width;
    screenHi = _mediaQuerydata.size.height;
    horizontalScreenSize = screenWi / 100;
    verticalScreenSize = screenWi / 100;
  }

  static sSize_385() {
    return horizontalScreenSize! * 106.953; //385
  }

  static sSize_360() {
    return horizontalScreenSize! * 96; //360
  }

  static sSize_350() {
    return horizontalScreenSize! * 95; //350
  }

  static sSize_300() {
    return horizontalScreenSize! * 86; //300
  }

  static sSize_275() {
    return horizontalScreenSize! * 75; //250
  }

  static sSize_250() {
    return horizontalScreenSize! * 69.45; //250
  }

  static sSize_210() {
    return horizontalScreenSize! * 60; //210
  }

  static sSize_200() {
    return horizontalScreenSize! * 57; //200
  }

  static sSize_170() {
    return horizontalScreenSize! * 51; //140
  }

  static sSize_160() {
    return horizontalScreenSize! * 50; //140
  }

  static sSize_150() {
    return horizontalScreenSize! * 43; //150
  }

  static sSize_140() {
    return horizontalScreenSize! * 38; //140
  }

  static sSize_120() {
    return horizontalScreenSize! * 33.344; //120
  }

  static sSize_110() {
    return horizontalScreenSize! * 30.562; //110
  }

  static sSize_100() {
    return horizontalScreenSize! * 27.78; //100
  }

  static sSize_95() {
    return horizontalScreenSize! * 26.50; //95
  }

  static sSize_90() {
    return horizontalScreenSize! * 25.008; //90
  }

  static sSize_82() {
    return horizontalScreenSize! * 22.4; //82
  }

  static sSize_80() {
    return horizontalScreenSize! * 20.514; //80
  }

  static sSize_75() {
    return horizontalScreenSize! * 20.85; //75
  }

  static sSize_70() {
    return horizontalScreenSize! * 19; //70
  }

  static sSize_60() {
    return horizontalScreenSize! * 16.672; //60
  }

  static sSize_55() {
    return horizontalScreenSize! * 15.281; //55
  }

  static sSize_50() {
    return horizontalScreenSize! * 13.89; //50
  }

  static sSize_48() {
    return horizontalScreenSize! * 13.38; //48
  }

  static sSize_45() {
    return horizontalScreenSize! * 12.51; //45
  }

  static sSize_40() {
    return horizontalScreenSize! * 10.257; //40
  }

  static sSize_38() {
    return horizontalScreenSize! * 10; //38
  }

  static sSize_34() {
    return horizontalScreenSize! * 9.5; //34
  }

  static sSize_30() {
    return horizontalScreenSize! * 8.336; //30
  }

  static sSize_28() {
    return horizontalScreenSize! * 7; //28
  }

  static sSize_25() {
    return horizontalScreenSize! * 6.945; //25
  }

  static sSize_24() {
    return horizontalScreenSize! * 6.690; //24
  }

  static sSize_20() {
    return horizontalScreenSize! * 5.560; //20
  }

  static sSize_18() {
    return horizontalScreenSize! * 5.0; //18
  }

  static sSize_17() {
    return horizontalScreenSize! * 4.75; //17
  }

  static sSize_16() {
    return horizontalScreenSize! * 4.450; //16
  }

  static sSize_15() {
    return horizontalScreenSize! * 4.170; //15
  }

  static sSize_14() {
    return horizontalScreenSize! * 3.900; //14
  }

  static sSize_11() {
    return horizontalScreenSize! * 3.06; //11
  }

  static sSize_12() {
    return horizontalScreenSize! * 3.360; //12
  }

  static sSize_13() {
    return horizontalScreenSize! * 3.637; //13
  }

  static sSize_10() {
    return horizontalScreenSize! * 2.800; //10
  }

  static sSize_8() {
    return horizontalScreenSize! * 2.245; //8
  }

  static sSize_6() {
    return horizontalScreenSize! * 1.685; //6
  }

  static sSize_4() {
    return horizontalScreenSize! * 1.120; //4
  }

  static sSize_3() {
    return horizontalScreenSize! * 0.8425; //6
  }

  static sSize_2() {
    return horizontalScreenSize! * 0.560; //4
  }
}
