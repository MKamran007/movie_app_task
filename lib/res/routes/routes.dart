import 'package:get/get.dart';
import 'package:movie_app_task/res/routes/routes_names.dart';
import 'package:movie_app_task/view/home_screen.dart';
import 'package:movie_app_task/view/splash_screen.dart';

import '../../view/favorite_movies_screen.dart';

class AppRoutes{
  static appRoutes () => [
    GetPage(
        name: RouteName.splashScreen,
        page: ()=> const SplashScreen(),
    ),
    GetPage(
      name: RouteName.homeScreen,
      page: ()=> const HomeScreen(),
    ),
    GetPage(
      name: RouteName.favoriteScreen,
      page: ()=> FavoritesScreen(),
    ),
  ];
}