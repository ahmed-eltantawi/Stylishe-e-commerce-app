import 'package:dio/dio.dart';

void main() async {
  try {
    final dio = Dio();
    final res = await dio.get('https://api.escuelajs.co/api/v1/products', queryParameters: {'categoryId': 1, 'limit': 2, 'offset': 0});
    print("category 1: ${res.data.map((p) => p['id']).toList()}");

    final res2 = await dio.get('https://api.escuelajs.co/api/v1/products', queryParameters: {'categoryId': 2, 'limit': 2, 'offset': 0});
    print("category 2: ${res2.data.map((p) => p['id']).toList()}");
  } catch (e) {
    if (e is DioException) {
      print("error: ${e.response?.data}");
    }
  }
}
