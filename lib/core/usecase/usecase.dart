import 'package:fpdart/fpdart.dart';
import '../error/errors.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}