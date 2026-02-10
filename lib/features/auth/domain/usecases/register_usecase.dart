import 'package:alsama/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  const RegisterUseCase(this._repository);

  Future<Either<Failure, AuthResult>> call({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? address,
    String? city,
  }) async {
    return await _repository.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
      address: address,
      city: city,
    );
  }
}
