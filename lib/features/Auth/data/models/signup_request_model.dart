import 'package:stylish/core/networking/api_end_points.dart';

class SignupRequestModel {
  final String name;
  final String email;
  final String password;
  final String avatar;

  SignupRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.name: name,
      ApiKey.email: email,
      ApiKey.password: password,
      ApiKey.avatar: avatar,
    };
  }
}
