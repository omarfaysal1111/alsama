import 'package:alsama/core/constants/app_constants.dart';
import 'package:alsama/core/errors/exceptions.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../models/auth_result_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResultModel> login({
    required String email,
    required String password,
  });

  Future<AuthResultModel> register({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? address,
    String? city,
  });

  Future<void> logout();

  Future<UserModel> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<AuthResultModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          return AuthResultModel.fromLoginResponse(responseData);
        }

        throw ServerException(message: 'Invalid response format');
      } else {
        throw ServerException(message: 'Login failed');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 404) {
        throw ServerException(message: 'اسم المستخدم أو كلمة المرور غير صحيحة');
      }
      throw ServerException(
        message: e.response?.data?['message'] as String? ?? 'فشل تسجيل الدخول',
      );
    } catch (e) {
      throw ServerException(message: 'فشل تسجيل الدخول: ${e.toString()}');
    }
  }

  @override
  Future<AuthResultModel> register({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? address,
    String? city,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'phone1': phone ?? '',
          'email': email,
          'address': address ?? city ?? '',
          'customertype': '1',
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData['message'] == 0) {
          final user = UserModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            email: email,
            name: name,
            phone: phone,
            address: address ?? city,
          );

          return AuthResultModel.fromRegisterResponse(user: user);
        } else {
          final errorMessage =
              responseData['message']?.toString() ?? 'فشل التسجيل';
          throw ServerException(message: errorMessage);
        }
      } else {
        throw ServerException(message: 'فشل التسجيل');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw ServerException(message: 'البريد الإلكتروني مستخدم بالفعل');
      }
      throw ServerException(
        message: e.response?.data?['message'] as String? ?? 'فشل التسجيل',
      );
    } catch (e) {
      throw ServerException(message: 'فشل التسجيل: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post(ApiEndpoints.logout);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] as String? ?? 'Logout failed',
      );
    } catch (e) {
      throw ServerException(message: 'Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _dio.get(ApiEndpoints.getProfile);

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(message: 'Failed to get user');
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] as String? ?? 'Failed to get user',
      );
    } catch (e) {
      throw ServerException(message: 'Failed to get user: ${e.toString()}');
    }
  }
}
