import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hmb_app/controller/auth_controller.dart';
import 'package:hmb_app/sheared/default_btn.dart';
import 'package:hmb_app/sheared/input_form_widget.dart';
import 'package:hmb_app/utils/constants.dart';
import 'package:hmb_app/utils/size_config.dart';
import 'package:hmb_app/view/profile/widget/profile_row_widget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController authController = Get.find();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Update Profile',
                              style: kRegularText.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputFormWidget(
                            fieldController: nameController,
                            labelText: 'Display Name',
                            hintText: 'Enter Display Name',
                            fillColor: kOrdinaryColor2,
                            icon: Icons.person,
                            keyType: TextInputType.text,
                            validation: (value) {
                              if (value.isEmpty) {
                                return kNameNullError;
                              }
                              return null;
                            },
                          ),
                          InputFormWidget(
                            fieldController: emailController,
                            labelText: 'Email',
                            hintText: 'Enter Email',
                            icon: Icons.email,
                            fillColor: kOrdinaryColor2,
                            keyType: TextInputType.emailAddress,
                            validation: (value) {
                              if (value.isEmpty) {
                                return kEmailNullError;
                              } else if (!emailValidatorRegExp
                                  .hasMatch(value)) {
                                return kInvalidEmailError;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: SizeConfig.screenWidth / 2.5,
                                child: DefaultBtn(
                                  title: 'Cancel',
                                  isChange: true,
                                  padding: 10,
                                  radius: 10,
                                  color: kErrorColor,
                                  onPress: () {
                                    nameController.clear();
                                    emailController.clear();
                                    Get.back();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth / 2.5,
                                child: DefaultBtn(
                                  title: 'Submit',
                                  isChange: true,
                                  padding: 10,
                                  radius: 10,
                                  onPress: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await authController.auth.currentUser
                                          ?.updateDisplayName(
                                              nameController.text);
                                      await authController.auth.currentUser
                                          ?.updateEmail(emailController.text);
                                      nameController.clear();
                                      emailController.clear();
                                      Get.back();
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                backgroundColor: kWhiteColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                isScrollControlled: true,
              );
            },
            icon: Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: kPrimaryColor,
                width: 4,
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: getProportionateScreenWidth(120),
                    width: getProportionateScreenWidth(120),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          kImageDir + 'man.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: -12,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            authController.auth.currentUser?.displayName ?? 'No Name',
            style: kRegularText.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            authController.auth.currentUser?.email ?? '',
            style: kRegularText.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ProfileRowWidget(
            title: 'Log Out',
            icon: Icons.logout,
            onPress: () {
              Get.defaultDialog(
                title: 'Are you sure?',
                content: const Text('It will logout from your account!'),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                    ),
                    onPressed: () {
                      authController.logOut();
                    },
                    child: const Text("Confirm"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                ],
              );
            },
          ),
          ProfileRowWidget(
            title: 'Exit',
            icon: Icons.exit_to_app,
            onPress: () {
              Get.defaultDialog(
                title: 'Are you sure?',
                content: const Text('It will exit from app!'),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                    ),
                    onPressed: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: const Text("Confirm"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
