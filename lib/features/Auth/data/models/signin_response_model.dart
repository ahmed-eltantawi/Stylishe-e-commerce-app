import 'package:stylish/core/networking/api_end_points.dart';

class SignInResponseModel {
  final String accessToken;
  final String refreshToken;

  SignInResponseModel({required this.accessToken, required this.refreshToken});

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) {
    return SignInResponseModel(
      accessToken: json[ApiKey.accessToken],
      refreshToken: json[ApiKey.refreshToken],
    );
  }
}
