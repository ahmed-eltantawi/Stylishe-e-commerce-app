import 'package:stylish/core/api/end_points.dart';

class SingUpModel {
  final String email;
  final String password;

  SingUpModel({required this.email, required this.password});

  factory SingUpModel.fromJson(Map<String, dynamic> json) =>
      SingUpModel(email: json[ApiKey.email], password: json[ApiKey.password]);
}
