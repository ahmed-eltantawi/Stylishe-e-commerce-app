import 'package:stylish/core/api/end_points.dart';

class SignUpModel {
  final String email;
  final String password;

  SignUpModel({required this.email, required this.password});

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      SignUpModel(email: json[ApiKey.email], password: json[ApiKey.password]);
}
