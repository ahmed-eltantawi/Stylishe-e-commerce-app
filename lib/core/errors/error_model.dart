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

// I made this class because the server returns a different error message
// if the statues code is 400 in the signup endpoint the api sends a List of error messages
class SingUpErrorModel extends ErrorModel {
  SingUpErrorModel({required super.statusCode, required super.errorMessage});

  factory SingUpErrorModel.fromJson(Map<String, dynamic> json) {
    return SingUpErrorModel(
      statusCode: json[ApiKey.statusCode],
      errorMessage: json[ApiKey.errorMessage][0],
    );
  }
}

class Success {
  const Success();
}
