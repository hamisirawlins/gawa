import 'package:fpdart/fpdart.dart';
import 'package:gawa/core/common/entities/user.dart';

import '../../../../core/error/errors.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> loginWithEmail(
      {required String email, required String password});
  Future<Either<Failure, User>> registerWithEmail(
      {required String email, required String password});
  Future<Either<Failure, User>> currentUser();
}
