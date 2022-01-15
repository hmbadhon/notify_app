import 'package:flutter/material.dart';
import 'package:hmb_app/utils/constants.dart';

class ProfileRowWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function? onPress;
  ProfileRowWidget({
    Key? key,
    this.title,
    this.icon,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          kOrdinaryShadow,
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onPress as void Function(),
        splashColor: kPrimaryColor,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(.3),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title ?? '',
              style: kRegularText2.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
