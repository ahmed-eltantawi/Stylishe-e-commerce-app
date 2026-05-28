import 'package:stylish/core/networking/api_end_points.dart';

class SignupResponseModel {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;
  final DateTime creationAt;
  final DateTime updatedAt;

  SignupResponseModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    required this.creationAt,
    required this.updatedAt,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      id: json[ApiKey.id],
      email: json[ApiKey.email],
      password: json[ApiKey.password],
      name: json[ApiKey.name],
      role: json[ApiKey.role],
      avatar: json[ApiKey.avatar],
      creationAt: DateTime.parse(json[ApiKey.creationAt]),
      updatedAt: DateTime.parse(json[ApiKey.updatedAt]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.id: id,
      ApiKey.email: email,
      ApiKey.password: password,
      ApiKey.name: name,
      ApiKey.role: role,
      ApiKey.avatar: avatar,
      ApiKey.creationAt: creationAt.toIso8601String(),
      ApiKey.updatedAt: updatedAt.toIso8601String(),
    };
  }
}
