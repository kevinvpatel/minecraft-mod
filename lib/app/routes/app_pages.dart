import 'package:get/get.dart';

import '../modules/category_screen/bindings/category_screen_binding.dart';
import '../modules/category_screen/views/category_screen_view.dart';
import '../modules/detail_screen/bindings/detail_screen_binding.dart';
import '../modules/detail_screen/views/detail_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/info_screen/bindings/info_screen_binding.dart';
import '../modules/info_screen/views/info_screen_view.dart';
import '../modules/list_screen/bindings/list_screen_binding.dart';
import '../modules/list_screen/views/list_screen_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LIST_SCREEN,
      page: () => const ListScreenView(),
      binding: ListScreenBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SCREEN,
      page: () => const DetailScreenView(),
      binding: DetailScreenBinding(),
    ),
    GetPage(
      name: _Paths.INFO_SCREEN,
      page: () => const InfoScreenView(),
      binding: InfoScreenBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_SCREEN,
      page: () => const CategoryScreenView(),
      binding: CategoryScreenBinding(),
    ),
  ];
}
