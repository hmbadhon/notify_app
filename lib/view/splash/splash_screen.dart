import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmb_app/utils/constants.dart';
import 'package:hmb_app/utils/size_config.dart';
import 'package:hmb_app/view/auth/signup_screen.dart';
import 'package:hmb_app/view/root/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    SharedPreferences.getInstance().then((pr) {
      prefs = pr;
    });
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animation.addListener(() => setState(() {}));
    _animationController.forward();
    Timer(
      const Duration(seconds: 2),
      () {
        if (prefs!.containsKey('token')) {
          Get.offAll(() => MainScreen());
        } else {
          Get.offAll(() => SignUpScreen());
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Hero(
            tag: 'logo',
            child: Image.asset(
              kImageDir + 'logo.png',
              width: _animation.value * getProportionateScreenWidth(350),
              height: _animation.value * getProportionateScreenHeight(250),
            ),
          ),
        ),
      ),
    );
  }
}
