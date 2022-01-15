import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'size_config.dart';

const String kImageDir = 'assets/images/';
const String kImageUrl = 'http://image.tmdb.org/t/p/w185';
// const String kBase64Extend = 'data:image/jpeg;base64,';
// const String kBase64ExtendVideo = 'data:video/mp4;base64,';
// const String kBase64ExtendAudio = 'data:audio/mp3;base64,';

/// Color const start here  ///

const kPrimaryColor = Color(0xFF032541);
const kSecondaryColor = Color(0xFF1FB9D6);
const kWhiteColor = Colors.white;
const kBlackColor = Colors.black;
const kDarkGrayColor = Color(0xFF4E4E4E);
const kOrdinaryColor = Color(0xFFA1A1A1);
const kOrdinaryColor2 = Color(0xFFEEEEEE);
const kBackGroundColor = Color(0xFF2A2C36);
const kDarkColor = Color(0xFF1E1F28);
const kGoldColor = Color(0xFFFFD700);
const kErrorColor = Color(0xFFFF2424);
const kSuccessColor = Color(0xFF55D85A);
const kSaleColor = Color(0xFFF14705);
const kIconColor = Color(0xFFF9784F);
const kSubscriptionColor = Color(0xFFF2C822);

/// Color const end here  ///

final kOrdinaryShadow = BoxShadow(
  color: kOrdinaryColor.withOpacity(.15),
  spreadRadius: 1,
  blurRadius: 1,
  offset: Offset(0, 1),
);

final kHomeTitle = TextStyle(
  color: kBlackColor,
  fontWeight: FontWeight.w600,
  fontSize: getProportionateScreenWidth(18),
);

final kHeadLine = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(34.0),
  fontWeight: FontWeight.w700,
  height: 1.25,
);
final kHeadLineTest = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(34.0),
  fontWeight: FontWeight.w700,
  height: 1.25,
);
final kHeadLine2 = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(24.0),
  fontWeight: FontWeight.w600,
  height: 1.25,
);
final kHeadLine3 = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(22.0),
  fontWeight: FontWeight.w500,
  height: 1.25,
);
final kRegularText = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(16.0),
  fontWeight: FontWeight.w400,
  height: 1.25,
);
final kRegularText2 = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(14.0),
  fontWeight: FontWeight.w400,
  height: 1.25,
);
final kDescriptionText = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(12.0),
  fontWeight: FontWeight.w400,
  height: 1.25,
);
final kSmallText = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(11.0),
  fontWeight: FontWeight.w400,
  height: 1.25,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp passwordValidatorRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter valid Email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password is too short";
const String kWeakPassError = "Password is too week, use Strong one";
const String kMatchPassError = "Passwords don't match";
const String kNameNullError = "Please enter your name";
const String kPhoneNumberNullError = "Please enter your phone number";
const String kAddressNullError = "Please enter your address";
const String kInvalidNumberError = "Invalid phone number";

final otpInputDecoration = InputDecoration(
  fillColor: kWhiteColor,
  contentPadding: const EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: kOrdinaryColor),
  );
}

void showCustomSnackBar(String message, {bool isError = true}) {
  Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        message,
        style: kRegularText2.copyWith(
          color: isError ? kErrorColor : kSuccessColor,
        ),
      ),
      maxWidth: SizeConfig.screenWidth,
      duration: const Duration(seconds: 2),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10),
      borderRadius: 5,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ),
  );
}
