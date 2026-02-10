import 'package:alsama/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<Either<Failure, AuthResult>> call({
    required String email,
    required String password,
  }) async {
    return await _repository.login(email: email, password: password);
  }
}
