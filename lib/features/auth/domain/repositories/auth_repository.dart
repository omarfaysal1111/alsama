import 'package:alsama/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/auth_result.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResult>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResult>> register({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? address,
    String? city,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, bool>> isLoggedIn();

  Future<Either<Failure, String>> getToken();
}
