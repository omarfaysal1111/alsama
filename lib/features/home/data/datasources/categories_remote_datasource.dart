import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final Dio _dio;

  CategoriesRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getCategories,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // The API returns { "message": 0, "data": [...] }
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final List<dynamic> data = responseData['data'] ?? [];
          return data.map((json) => CategoryModel.fromJson(json as Map<String, dynamic>)).toList();
        } else if (responseData is List) {
          // Handle case where API directly returns a list
          return responseData.map((json) => CategoryModel.fromJson(json as Map<String, dynamic>)).toList();
        } else {
          throw ServerException(
            message: 'Invalid response format',
            code: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: 'Failed to fetch categories: ${response.statusMessage}',
          code: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(
          message: 'Connection timeout. Please check your internet connection.',
          code: e.response?.statusCode,
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
          message: 'No internet connection. Please check your network.',
          code: e.response?.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch categories: ${e.message}',
          code: e.response?.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(
        message: 'Unexpected error: ${e.toString()}',
        code: 500,
      );
    }
  }
}

