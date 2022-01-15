import 'package:flutter/material.dart';
import 'package:hmb_app/utils/constants.dart';

class DefaultBtn extends StatelessWidget {
  final String? title;
  final Function? onPress;
  final bool? isChange;
  final double? radius;
  final double? padding;
  final Color? color;
  DefaultBtn({
    Key? key,
    @required this.title,
    this.color,
    this.onPress,
    this.padding,
    this.isChange = false,
    this.radius,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress as void Function(),
      style: ElevatedButton.styleFrom(
        primary: isChange == false ? kPrimaryColor : color,
        // onPrimary: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: isChange == false
              ? BorderRadius.circular(25)
              : BorderRadius.circular(radius!),
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: isChange == false ? 12 : padding!),
        child: Text(
          title ?? '',
          style: kRegularText.copyWith(color: kWhiteColor),
        ),
      ),
    );
  }
}
