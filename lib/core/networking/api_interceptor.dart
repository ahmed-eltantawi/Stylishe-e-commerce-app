import 'dart:async';

import 'package:dio/dio.dart';
import 'package:stylish/config/services/secure_storage_service.dart';
import 'package:stylish/core/networking/api_end_points.dart';
import 'package:stylish/core/utils/app_constants.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  static Completer<bool>? _refreshCompleter;
  ApiInterceptor(this.dio);

  // This will be called for each request
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // get Access token from secure storage
    final accessToken = await SecureStorageService.getAccessToken();

    // Add the access token to the request header
    options.headers[ApiHeaderKey.authorization] =
        ApiHeaderKey.getAuthorizationValue(accessToken: accessToken);

    // Add the language code to the request header
    options.headers[ApiHeaderKey.acceptLanguage] = AppConstants.languageCode;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (_refreshCompleter != null) {
        final success = await _refreshCompleter!.future;

        if (success) {
          final accessToken = await SecureStorageService.getAccessToken();

          err.requestOptions.headers[ApiHeaderKey.authorization] =
              ApiHeaderKey.getAuthorizationValue(accessToken: accessToken);

          try {
            final response = await dio.fetch(err.requestOptions);
            return handler.resolve(response);
          } on DioException catch (e) {
            return handler.next(err);
          }
        } else {
          return handler.next(err);
        }
      }

      _refreshCompleter = Completer<bool>();

      final refreshToken = await SecureStorageService.getRefreshToken();

      if (refreshToken == null) {
        _refreshCompleter!.complete(false);
        _refreshCompleter = null;
        await _performLogout();
        return handler.next(err);
      }

      try{
        final refreshDio = Dio(BaseOptions(
         baseUrl: EndPoint.baseUrl,
        ));

        final response = await refreshDio.post(
          EndPoint.refreshToken,
          data: {ApiKey.refreshToken: refreshToken},
        );

        final newAccessToken = response.data[ApiKey.accessToken]  as String;
        final newRefreshToken = response.data[ApiKey.refreshToken]as String;
        
         await SecureStorageService.saveTokens(accessToken: newAccessToken, refreshToken: newRefreshToken);
     
     // TODO: 32:00
     
     
     }
    }
  }
}
