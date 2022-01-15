import 'package:flutter/material.dart';
import 'package:hmb_app/utils/constants.dart';

class InputFormWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? initialText;
  final TextEditingController? fieldController;
  final Function? onSaved;
  final Function? validation;
  final IconData? icon;
  final int? maxLines;
  final int? maxLength;
  final String? preText;
  final Color? fillColor;
  final bool? isProtected;
  final bool? isEditable;
  final bool? centerText;
  final FocusNode? focusNode;
  final TextInputType? keyType;
  InputFormWidget({
    this.preText,
    this.initialText,
    this.isEditable,
    this.maxLines,
    this.maxLength,
    this.centerText = false,
    this.validation,
    this.focusNode,
    this.labelText,
    this.fillColor,
    this.isProtected = false,
    this.hintText,
    this.icon,
    this.fieldController,
    this.keyType,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        maxLines: maxLines ?? 1,
        enabled: isEditable,
        maxLength: maxLength,
        validator: validation as String? Function(String?)?,
        controller: fieldController,
        keyboardType: keyType,
        obscureText: isProtected!,
        obscuringCharacter: '*',
        onChanged: onSaved as void Function(String)?,
        focusNode: focusNode,
        textAlign: centerText == true ? TextAlign.center : TextAlign.start,
        autofocus: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          errorStyle: const TextStyle(fontSize: 11, height: 0.3),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          prefixText: preText,
          prefixStyle: const TextStyle(
            fontSize: 16,
          ),
          suffixIcon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          labelText: labelText,
          labelStyle: kRegularText.copyWith(
            color: kPrimaryColor,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: kOrdinaryColor,
          ),
          filled: fillColor == null ? false : true,
          fillColor: fillColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          // hintStyle: kDescriptionText.copyWith(color: kWhiteColor),
          alignLabelWithHint: true,
          // border: new OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(5),
          //   borderSide: BorderSide(color: fillColor,width: 0),
          //   gapPadding: 3,
          // ),
        ),
      ),
    );
  }
}
