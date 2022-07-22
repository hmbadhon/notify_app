import 'package:fcm_config/fcm_config.dart';
import 'package:get/get.dart';
import 'package:hmb_app/services/network_service.dart';

class NotificationsController extends GetxController {
  RemoteMessage? _notification;
  var isLoading = false.obs;

  RemoteMessage? get getNotification => _notification;

  void sendPushNotification({
    String? title,
    String? body,
    int? pageNumber,
  }) {
    NetworkServices().send(
      title: title,
      body: body,
      pageNumber: pageNumber,
    );
  }

  void sendLocalNotification({
    String? title,
    String? body,
    int? pageNumber,
  }) {
    FCMConfig.instance.local.displayNotification(
      title: title,
      body: body,
      // android: AndroidNotificationDetails(
      //   'channelId',
      //   'channelName',
      //   color: Color.red,
      // ),
      data: <String, dynamic>{
        'id': pageNumber,
        'status': 'page',
      },
    );
  }

  Future<void> setData(RemoteMessage? notification) async {
    try {
      isLoading(true);
      _notification = notification;
    } finally {
      isLoading(false);
    }
  }
}
