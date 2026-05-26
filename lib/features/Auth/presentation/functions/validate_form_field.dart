import 'package:flutter/material.dart';
import 'package:stylish/generated/l10n.dart';

String? validateFormField({
  required BuildContext context,
  required String? value,
  required String hintText,
  required bool isPassword,
}) {
  // make sure that the value is not empty
  if (value!.isEmpty) {
    return '$hintText ${S.of(context).isRequired}';
  }
  // check if it is a password
  // and make sure that the length is more than 6
  else if (isPassword && value.length < 6) {
    return S.of(context).passwordMustBeAtLeast6Characters;
  }
  // check if it is an email and
  // make sure that the email is valid
  else if (!isPassword && !value.contains("@") && !value.contains(".")) {
    return S.of(context).pleaseEnterValidEmail;
  }
  // else return null to continue the process
  else {
    return null;
  }
}
