import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmb_app/utils/size_config.dart';
import 'package:hmb_app/view/root/main_screen.dart';

class VerificationSuccess extends StatefulWidget {
  const VerificationSuccess({Key? key}) : super(key: key);

  @override
  _VerificationSuccessState createState() => _VerificationSuccessState();
}

class _VerificationSuccessState extends State<VerificationSuccess> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      Get.offAll(() => MainScreen());
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified,
              size: getProportionateScreenWidth(100),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Verification Successful!'),
          ],
        ),
      ),
    );
  }
}
