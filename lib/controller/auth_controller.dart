import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmb_app/main.dart';
import 'package:hmb_app/sheared/custom_loader.dart';
import 'package:hmb_app/utils/constants.dart';
import 'package:hmb_app/view/auth/email_verify_waiting.dart';
import 'package:hmb_app/view/auth/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;

  Future<void> loginUser({
    BuildContext? context,
    String? email,
    String? password,
  }) async {
    try {
      showDialog(
        context: context!,
        barrierDismissible: false,
        builder: (_) => const CustomLoader(
          color: kWhiteColor,
        ),
      );
      await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      Get.back();

      Get.offAll(() => EmailVerifyWaitingScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.back();
        showCustomSnackBar('No user found for that email');
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.back();
        showCustomSnackBar('Wrong password provided for that user');

        log('Wrong password provided for that user.');
      }
    }
  }

  Future<void> registerUser({
    BuildContext? context,
    String? email,
    String? password,
  }) async {
    try {
      showDialog(
          context: context!,
          barrierDismissible: false,
          builder: (_) => const CustomLoader(
                color: kWhiteColor,
              ));
      await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      Get.back();

      Get.offAll(() => EmailVerifyWaitingScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.back();
        showCustomSnackBar('The account already exists for that email');
        log('The account already exists for that email.');
      }
    } catch (e) {
      Get.back();
      showCustomSnackBar(e.toString());
      log(e.toString());
    }
  }

  Future<void> logOut() async {
    _auth.signOut();
    prefs!.clear();
    Get.offAll(() => LoginScreen());
  }
}
