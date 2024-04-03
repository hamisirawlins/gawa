import 'package:fpdart/fpdart.dart';
import 'package:gawa/core/error/errors.dart';
import 'package:gawa/core/error/exceptions.dart';
import 'package:gawa/modules/auth/data/datasources/auth_remote_data.dart';
import 'package:gawa/core/common/entities/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteData;
  const AuthRepoImpl(this.authRemoteData);

  @override
  Future<Either<Failure, User>> loginWithEmail(
      {required String email, required String password}) async {
    return _getUser(() async =>
        await authRemoteData.loginWithEmail(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> registerWithEmail(
      {required String email, required String password}) async {
    return _getUser(() async => await authRemoteData.registerWithEmail(
        email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await authRemoteData.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
