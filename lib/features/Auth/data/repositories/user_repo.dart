import 'package:dartz/dartz.dart';
import 'package:stylish/core/api/dio_consumer.dart';
import 'package:stylish/core/api/end_points.dart';
import 'package:stylish/core/errors/exceptions.dart';
import 'package:stylish/features/Auth/data/models/signin_model.dart';

class UserRepo {
  const UserRepo({required this.dioConsumer});
  final DioConsumer dioConsumer;

  Future<Either<String, SigninModel>> singIn({
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> response = await dioConsumer.post(
        EndPoint.login,
        data: {'email': email, 'password': password},
      );
      return Right(SigninModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
