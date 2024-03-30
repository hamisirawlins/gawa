import 'package:fpdart/fpdart.dart';
import 'package:gawa/core/usecase/usecase.dart';
import 'package:gawa/core/common/entities/user.dart';
import 'package:gawa/modules/auth/domain/repository/auth_repo.dart';
import '../../../../core/error/errors.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository _authRepository;
  UserLogin(this._authRepository);

  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await _authRepository.loginWithEmail(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
