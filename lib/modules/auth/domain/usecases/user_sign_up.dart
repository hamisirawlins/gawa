import 'package:fpdart/fpdart.dart';
import 'package:gawa/core/error/errors.dart';
import 'package:gawa/core/usecase/usecase.dart';
import 'package:gawa/modules/auth/domain/repository/auth_repo.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRepository.registerWithEmail(
        email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String password;

  UserSignUpParams({required this.email, required this.password});
}
