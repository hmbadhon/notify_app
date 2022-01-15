import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NetworkServices {
  final String serverKey =
      'AAAAVIMIBeQ:APA91bFv64-9D59ST2XKcONUwmBg7uhHYZ4znUAxoYANyjTDUsK6hq033EA5JeGMQCQbI7BjYdqRPHu8W-JhjolNrNeOxAZ85p50qrPSWHlM3rm3mhTUSdncsfBmod-D9YnZipw2cb0e';
  static var client = http.Client();

  void send({
    String? title,
    String? body,
    int? pageNumber,
  }) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': title,
            'title': body,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'id': pageNumber,
            'status': 'page',
          },
          'to': await FirebaseMessaging.instance.getToken(),
        },
      ),
    );
  }
}
