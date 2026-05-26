String? validateFormField({
  required String? value,
  required String hintText,
  required bool isPassword,
}) {
  // make sure that the value is not empty
  if (value!.isEmpty) {
    return '$hintText is required';
  }
  // check if it is a password
  // and make sure that the length is more than 6
  else if (isPassword && value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  // check if it is an email and
  // make sure that the email is valid
  else if (isPassword && !value.contains("@") && !value.contains(".")) {
    return 'Please enter a valid email';
  }
  // else return null to continue the process
  else {
    return null;
  }
}
