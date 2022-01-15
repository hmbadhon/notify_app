import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmb_app/controller/auth_controller.dart';
import 'package:hmb_app/main.dart';
import 'package:hmb_app/utils/size_config.dart';
import 'package:hmb_app/view/auth/verification_success.dart';

class EmailVerifyWaitingScreen extends StatefulWidget {
  const EmailVerifyWaitingScreen({Key? key}) : super(key: key);

  @override
  _EmailVerifyWaitingScreenState createState() =>
      _EmailVerifyWaitingScreenState();
}

class _EmailVerifyWaitingScreenState extends State<EmailVerifyWaitingScreen> {
  final AuthController authController = Get.find();
  late Timer timer;

  @override
  void initState() {
    if (authController.auth.currentUser!.emailVerified) {
      timer = Timer.periodic(Duration(seconds: 0), (timer) {
        checkEmailVerification();
      });
    } else {
      authController.auth.currentUser!.sendEmailVerification();
      timer = Timer.periodic(Duration(seconds: 5), (timer) {
        checkEmailVerification();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerification() async {
    authController.auth.currentUser!.reload();
    if (authController.auth.currentUser!.emailVerified) {
      timer.cancel();
      prefs!.setBool('token', true);
      prefs!.setString('name', authController.auth.currentUser!.email ?? '');
      Get.offAll(() => VerificationSuccess());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.link,
              size: getProportionateScreenWidth(100),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Waiting!'),
          ],
        ),
      ),
    );
  }
}
