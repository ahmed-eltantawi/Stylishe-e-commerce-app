abstract class EndPoint {
  static const String baseUrl = "https://api.escuelajs.co/api/v1/";
  static const String login = "auth/login";
  static const String register = "users/";
  static const String uploadImage = "files/upload";
  static String getUser({required int id}) => "users/$id";
}

abstract class ApiKey {
  static const String statusCode = "statusCode";
  static const String errorMessage = "message";
  static const String email = 'email';
  static const String password = 'password';
  static const String id = 'id';
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenId = "sub";
  static const String name = "name";
  static const String avatar = "avatar";
  static const String creationAt = "creationAt";
  static const String updatedAt = "updatedAt";
  static const String role = "role";
}

abstract class ApiHeaderKey {
  static const String authorization = "Authorization";
  static const String bearer = "Bearer ";
  static const String acceptLanguage = "Accept-Language";
}
