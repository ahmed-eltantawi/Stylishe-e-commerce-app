import 'dart:async';

import 'package:dio/dio.dart';
import 'package:stylish/config/services/secure_storage_service.dart';
import 'package:stylish/config/services/shared_preferences_service.dart';
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

      try {
        final refreshDio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl));

        final response = await refreshDio.post(
          EndPoint.refreshToken,
          data: {ApiKey.refreshToken: refreshToken},
        );

        final newAccessToken = response.data[ApiKey.accessToken] as String;
        final newRefreshToken = response.data[ApiKey.refreshToken] as String;

        await SecureStorageService.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );

        _refreshCompleter!.complete(true);
        _refreshCompleter = null;

        err.requestOptions.headers[ApiHeaderKey.authorization] =
            ApiHeaderKey.getAuthorizationValue(
              accessToken: ApiHeaderKey.getAuthorizationValue(
                accessToken: newAccessToken,
              ),
            );

        final retryResponse = await dio.fetch(err.requestOptions);
        return handler.resolve(retryResponse);
      } catch (e) {
        _refreshCompleter!.complete(false);
        _refreshCompleter = null;
        await _performLogout();
        return handler.next(err);
      }
    }

    return super.onError(err, handler);
  }

  Future<void> _performLogout() async {
    await SharedPreferencesService.clearAuthData();
    await SecureStorageService.deleteTokens();
    AuthEventBus.instance.addEvent(AuthEvent.logout);
  }
}

enum AuthEvent { logout }

class AuthEventBus {
  AuthEventBus._();
  static final AuthEventBus instance = AuthEventBus._();

  final _streamController = StreamController<AuthEvent>.broadcast();
  Stream<AuthEvent> get stream => _streamController.stream;

  void addEvent(AuthEvent event) {
    if (!_streamController.isClosed) _streamController.add(event);
  }

  void close() => _streamController.close();
}
