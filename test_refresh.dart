import 'package:dio/dio.dart';

void main() async {
  try {
    final dio = Dio();
    final res = await dio.post('https://api.escuelajs.co/api/v1/auth/login', data: {'email': 'john@mail.com', 'password': 'changeme'});
    print("login response: ${res.data}");
  } catch (e) {
    if (e is DioException) {
      print("login error: ${e.response?.data}");
    }
  }
}
