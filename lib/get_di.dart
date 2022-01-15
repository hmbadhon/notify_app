import 'package:get/get.dart';
import 'package:hmb_app/controller/notifications_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/auth_controller.dart';
import 'main.dart';

Future<void> init() async {
  prefs = await SharedPreferences.getInstance();
  Get.lazyPut(
    () => AuthController(),
    fenix: true,
  );
  Get.lazyPut(
    () => NotificationsController(),
    fenix: true,
  );
}
