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
    final accessToken = SecureStorageService.getAccessToken();

    // Add the access token to the request header
    options.headers[ApiHeaderKey.authorization] =
        "${ApiHeaderKey.bearer} $accessToken";

    // Add the language code to the request header
    options.headers[ApiHeaderKey.acceptLanguage] = AppConstants.languageCode;
    super.onRequest(options, handler);
  }

  // TODO: onError Method
  // Form 27:00
}
