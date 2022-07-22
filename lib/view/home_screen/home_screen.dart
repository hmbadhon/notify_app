import 'dart:developer';

import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmb_app/controller/notifications_controller.dart';
import 'package:hmb_app/sheared/default_btn.dart';
import 'package:hmb_app/sheared/input_form_widget.dart';
import 'package:hmb_app/utils/constants.dart';
import 'package:hmb_app/utils/size_config.dart';
import 'package:hmb_app/view/home_screen/pages/first_screen.dart';
import 'package:hmb_app/view/home_screen/pages/fourth_screen.dart';
import 'package:hmb_app/view/home_screen/pages/second_screen.dart';
import 'package:hmb_app/view/home_screen/pages/third_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with FCMNotificationMixin, FCMNotificationClickMixin {
  final NotificationsController notificationsController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final List<Map<String, dynamic>> pagesList = [
    {
      'id': 1,
      'name': 'Page 1',
    },
    {
      'id': 2,
      'name': 'Page 2',
    },
    {
      'id': 3,
      'name': 'Page 3',
    },
    {
      'id': 4,
      'name': 'Page 4',
    },
  ];

  int? selectedPageId;

  @override
  void initState() {
    firebaseBgNotify();
    super.initState();
  }

  void firebaseBgNotify() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("Handling a background message: ${message.data}");
      // Get.to(() => NotificationScreen());
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  InputFormWidget(
                    fieldController: _titleController,
                    labelText: 'Title',
                    fillColor: kOrdinaryColor2,
                    keyType: TextInputType.emailAddress,
                    validation: (value) {
                      if (value.isEmpty) {
                        return 'Title Can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  InputFormWidget(
                    fieldController: _bodyController,
                    labelText: 'Body',
                    maxLines: 5,
                    maxLength: 240,
                    fillColor: kOrdinaryColor2,
                    validation: (value) {
                      if (value.isEmpty) {
                        return 'Body Can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<dynamic>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    hint: Text(
                      'Select Page',
                    ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    items: pagesList.map((e) {
                      return DropdownMenuItem<dynamic>(
                        child: Text(e['name']),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          selectedPageId = val['id'];
                          log(selectedPageId.toString());
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(35),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth / 2.5,
                          child: DefaultBtn(
                            title: 'Local Submit',
                            onPress: () async {
                              if (_formKey.currentState!.validate() &&
                                  selectedPageId != null) {
                                notificationsController.sendLocalNotification(
                                  title: _titleController.text,
                                  body: _bodyController.text,
                                  pageNumber: selectedPageId,
                                );
                              } else {
                                showCustomSnackBar('please select page');
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth / 2.5,
                          child: DefaultBtn(
                            title: 'Push Submit',
                            onPress: () async {
                              if (_formKey.currentState!.validate() &&
                                  selectedPageId != null) {
                                notificationsController.sendPushNotification(
                                  title: _titleController.text,
                                  body: _bodyController.text,
                                  pageNumber: selectedPageId,
                                );
                              } else {
                                showCustomSnackBar('please select page');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onNotify(RemoteMessage notification) {
    notificationsController.setData(notification);
    changeScreen(notification);
  }

  @override
  void onClick(RemoteMessage notification) {
    notificationsController.setData(notification);
    if (kDebugMode) {
      print(
          'Notification clicked with title: ${notification.notification?.title} && body: ${notification.notification?.body} && data: ${notification.data.toString()}');
    }
    changeScreen(notification);
  }

  void changeScreen(RemoteMessage notification) {
    if (notification.data.isNotEmpty) {
      if (notification.data['id'] == '1') {
        log(notification.data['id'].toString());
        Get.to(
          () => FirstScreen(),
        );
      } else if (notification.data['id'] == '2') {
        log(notification.data['id'].toString());
        Get.to(
          () => SecondScreen(),
        );
      } else if (notification.data['id'] == '3') {
        log(notification.data['id'].toString());
        Get.to(
          () => ThirdScreen(),
        );
      } else {
        log(notification.data['id'].toString());
        Get.to(
          () => FourthScreen(),
        );
      }
    }
  }
}
