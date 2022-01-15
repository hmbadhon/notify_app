import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hmb_app/utils/constants.dart';

class CustomLoader extends StatelessWidget {
  final Color? color;
  const CustomLoader({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SpinKitFadingCircle(
        color: color ?? kPrimaryColor,
        size: 40.0,
      ),
    );
  }
}
