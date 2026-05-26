import 'dart:convert';

import 'package:stylish/core/api/end_points.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_key.dart';
import 'package:stylish/core/services/services_locator.dart';
import 'package:stylish/features/Auth/data/models/user_model.dart';

UserModel? getUserFromDataCache() {
  final data = getIt<CacheHelper>().getData(key: CacheKey.userDataKey);

  if (data == null) return null;

  return UserModel.fromJson(jsonDecode(data), id: jsonDecode(data)[ApiKey.id]);
}
