import 'package:flutter/material.dart';
import 'package:movie_app_task/res/assets/image_assets.dart';

import '../res/routes/routes_names.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen(){
    Future.delayed(const Duration(seconds: 3) ,(){
      Navigator.pushNamed(context, RouteName.homeScreen);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 150,
            child: Image.asset(ImageAssets.splashScreen,),
        ),
      ),
    );
  }
}
