import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: put here the thing change the language
    options.headers["Accept-Language"] = "en";
    super.onRequest(options, handler);
  }
}
