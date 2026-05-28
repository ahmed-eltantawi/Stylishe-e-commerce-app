import 'package:stylish/core/networking/api_end_points.dart';

class UserModel {
  final String email;
  final String name;
  final String avatarUrl;
  final String role;
  final int id;
  final String creationAt;
  final String updatedAt;

  UserModel({
    required this.email,
    required this.name,
    required this.avatarUrl,
    required this.role,
    required this.id,
    required this.creationAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, {required int id}) {
    return UserModel(
      email: json[ApiKey.email],
      name: json[ApiKey.name],
      avatarUrl: json[ApiKey.avatar],
      role: json[ApiKey.role],
      creationAt: json[ApiKey.creationAt],
      updatedAt: json[ApiKey.updatedAt],
      id: id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.email: email,
      ApiKey.name: name,
      ApiKey.avatar: avatarUrl,
      ApiKey.role: role,
      ApiKey.creationAt: creationAt,
      ApiKey.updatedAt: updatedAt,
      ApiKey.id: id,
    };
  }
}
