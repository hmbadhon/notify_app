import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmb_app/controller/notifications_controller.dart';
import 'package:hmb_app/main.dart';
import 'package:hmb_app/sheared/custom_loader.dart';
import 'package:hmb_app/utils/constants.dart';

class ThirdScreen extends StatelessWidget {
  ThirdScreen({Key? key}) : super(key: key);
  final NotificationsController notificationsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: Obx(
        () {
          if (notificationsController.isLoading.isTrue) {
            return Center(
              child: CustomLoader(),
            );
          } else {
            if (notificationsController.getNotification == null) {
              return Center(
                child: Text(
                  'No Data Available',
                  style: kRegularText,
                ),
              );
            } else {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Hello, ${prefs!.getString('email')}'),
                  ),
                  ListTile(
                    title: const Text('title'),
                    subtitle: Text(notificationsController
                            .getNotification?.notification?.title ??
                        ''),
                  ),
                  ListTile(
                    title: const Text('Body'),
                    subtitle: Text(notificationsController
                            .getNotification?.notification?.body ??
                        'No notification'),
                  ),
                  if (notificationsController.getNotification?.data != null)
                    ListTile(
                      title: const Text('Page'),
                      subtitle: Text('Page ' +
                          '${notificationsController.getNotification?.data['id'].toString() ?? ''}'),
                    )
                ],
              );
            }
          }
        },
      ),
    );
  }
}
