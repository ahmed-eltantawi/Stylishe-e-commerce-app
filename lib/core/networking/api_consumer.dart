abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
    bool skipAuthInterceptor = false,
  });
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
    bool skipAuthInterceptor = false,
  });
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
    bool skipAuthInterceptor = false,
  });
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
    bool skipAuthInterceptor = false,
  });
}
