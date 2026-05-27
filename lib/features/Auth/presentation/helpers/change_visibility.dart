import 'package:flutter/material.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_text_form_field.dart';

void changeVisibility() {
  //* --- This Method changes the visibility of the password text field ---
  if (passwordIcon == Icons.visibility_outlined) {
    passwordIcon = Icons.visibility_off_outlined;
    obscurePassword = true;
  } else {
    passwordIcon = Icons.visibility_outlined;
    obscurePassword = false;
  }
}
