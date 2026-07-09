import 'package:dio/dio.dart';
import 'package:stylish/core/networking/api_consumer.dart';
import 'package:stylish/core/networking/api_interceptor.dart';
import 'package:stylish/core/networking/api_end_points.dart';
import 'package:stylish/core/errors/exceptions.dart';

class DioConsumer extends ApiConsumer {
  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(ApiInterceptor(dio));
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }
  final Dio dio;

  @override
  Future delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
    bool skipAuthInterceptor = false,
  }) async {
    try {
      final dynamic response = await dio.delete(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: skipAuthInterceptor ? {'skipAuthInterceptor': true} : null,
        ),
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
    bool skipAuthInterceptor = false,
  }) async {
    try {
      final dynamic response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: skipAuthInterceptor ? {'skipAuthInterceptor': true} : null,
        ),
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic data,
    bool isFormData = false,
    bool skipAuthInterceptor = false,
  }) async {
    try {
      final dynamic response = await dio.post(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: skipAuthInterceptor ? {'skipAuthInterceptor': true} : null,
        ),
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future put(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
    bool skipAuthInterceptor = false,
  }) async {
    try {
      final dynamic response = await dio.put(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: skipAuthInterceptor ? {'skipAuthInterceptor': true} : null,
        ),
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
