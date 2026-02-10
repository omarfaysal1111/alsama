import 'package:alsama/core/errors/exceptions.dart';
import 'package:alsama/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import '../../domain/entities/auth_result.dart' as domain;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, domain.AuthResult>> login({
    required String email,
    required String password,
  }) async {
    if (!await _networkInfo.isConnected) {
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      final result = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      // Cache the token and user
      await _localDataSource.cacheToken(result.token);
      await _localDataSource.cacheUser(result.user as UserModel);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, domain.AuthResult>> register({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? address,
    String? city,
  }) async {
    if (!await _networkInfo.isConnected) {
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      final result = await _remoteDataSource.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
        address: address,
        city: city,
      );

      // Cache the token and user
      await _localDataSource.cacheToken(result.token);
      await _localDataSource.cacheUser(result.user as UserModel);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Registration failed: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.logout();
      }

      // Clear local cache
      await _localDataSource.clearToken();
      await _localDataSource.clearUser();

      return const Right(null);
    } on ServerException catch (e) {
      // Even if remote logout fails, clear local cache
      await _localDataSource.clearToken();
      await _localDataSource.clearUser();
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      await _localDataSource.clearToken();
      await _localDataSource.clearUser();
      return Left(ServerFailure(message: 'Logout failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      // Try to get cached user first
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Right(cachedUser);
      }

      // If no cached user, fetch from remote
      if (!await _networkInfo.isConnected) {
        return Left(NetworkFailure(message: 'No internet connection'));
      }

      final user = await _remoteDataSource.getCurrentUser();
      await _localDataSource.cacheUser(user);

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get user: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final token = await _localDataSource.getToken();
      return Right(token != null && token.isNotEmpty);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = await _localDataSource.getToken();
      if (token != null) {
        return Right(token);
      } else {
        return Left(CacheFailure(message: 'No token found'));
      }
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to get token: ${e.toString()}'),
      );
    }
  }
}
