import 'package:fpdart/fpdart.dart';

import '../../../../core/error/errors.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> loginWithEmail(
      {required String email, required String password});
  Future<Either<Failure, String>> registerWithEmail(
      { required String email, required String password});
}
