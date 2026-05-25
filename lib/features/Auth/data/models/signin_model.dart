import 'package:stylish/core/api/end_points.dart';

class SigninModel {
  final String accessToken;
  final String refreshToken;

  SigninModel({required this.accessToken, required this.refreshToken});

  factory SigninModel.fromJson(Map<String, dynamic> json) {
    return SigninModel(
      accessToken: json[ApiKey.accessToken],
      refreshToken: json[ApiKey.refreshToken],
    );
  }
}
