import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> searchProducts(String query);
  Future<List<ProductModel>> getFeaturedProducts();
  Future<List<String>> getCategories();
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio _dio;

  ProductsRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    print('ProductsRemoteDataSource: getAllProducts called');
    try {
      print(
        'ProductsRemoteDataSource: Making API call to ${ApiEndpoints.getAllProducts}',
      );
      final response = await _dio.get(
        ApiEndpoints.getAllProducts,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      print(
        'ProductsRemoteDataSource: API response status: ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          message: 'Failed to fetch products: ${response.statusMessage}',
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
          message: 'Failed to fetch products: ${e.message}',
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

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.getProductById}/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: 'Failed to fetch product: ${response.statusMessage}',
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
          message: 'Failed to fetch product: ${e.message}',
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

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.searchProducts,
        queryParameters: {'q': query},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          message: 'Failed to search products: ${response.statusMessage}',
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
          message: 'Failed to search products: ${e.message}',
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

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getFeaturedProducts,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          message:
              'Failed to fetch featured products: ${response.statusMessage}',
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
          message: 'Failed to fetch featured products: ${e.message}',
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

  @override
  Future<List<String>> getCategories() async {
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
        final List<dynamic> data = response.data;
        return data.map((json) => json['name']?.toString() ?? '').toList();
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
