import 'package:fpdart/fpdart.dart';
import 'package:gawa/core/error/errors.dart';
import 'package:gawa/core/error/exceptions.dart';
import 'package:gawa/modules/auth/data/datasources/auth_remote_data.dart';
import '../../domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteData authRemoteData;
  const AuthRepoImpl(this.authRemoteData);

  @override
  Future<Either<Failure, String>> loginWithEmail(
      {required String email, required String password}) async {
    try {
      final userId = await authRemoteData.registerWithEmail(
          email: email, password: password);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> registerWithEmail(
      {required String email, required String password}) async {
    try {
      final userId = await authRemoteData.registerWithEmail(
          email: email, password: password);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
