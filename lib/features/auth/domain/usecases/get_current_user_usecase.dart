import 'package:alsama/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  const GetCurrentUserUseCase(this._repository);

  Future<Either<Failure, User>> call() async {
    return await _repository.getCurrentUser();
  }
}
