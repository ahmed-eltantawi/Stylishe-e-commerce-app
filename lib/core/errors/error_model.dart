import 'package:stylish/core/api/end_points.dart';

class ErrorModel {
  int statusCode;
  String errorMessage;
  ErrorModel({required this.statusCode, required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      statusCode: json[ApiKey.statusCode],
      errorMessage: json[ApiKey.errorMessage],
    );
  }
}

class Success {
  const Success();
}
