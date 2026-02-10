import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(String orderId);
  Future<OrderModel> createOrder(Map<String, dynamic> orderData);
  Future<OrderModel> cancelOrder(String orderId);
  Future<Map<String, dynamic>> trackOrder(String orderId);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final Dio _dio;

  OrdersRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getOrders,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        
        // Handle API response structure
        if (responseData is Map<String, dynamic> && responseData.containsKey('records')) {
          final List<dynamic> records = responseData['records'] as List<dynamic>;
          return records.map((json) => OrderModel.fromJson(json)).toList();
        } else if (responseData is List) {
          return responseData.map((json) => OrderModel.fromJson(json)).toList();
        } else {
          throw ServerException(
            message: 'Invalid response format',
            code: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: 'Failed to fetch orders: ${response.statusMessage}',
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
          message: 'Failed to fetch orders: ${e.message}',
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
  Future<OrderModel> getOrderById(String orderId) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.getOrderById}/$orderId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: 'Failed to fetch order: ${response.statusMessage}',
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
          message: 'Failed to fetch order: ${e.message}',
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
  Future<OrderModel> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.createOrder,
        data: orderData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          // addorder docs: successful response is { "message": 0 }
          if (responseData['message'] == 0) {
            final rows = (orderData['rows'] as List<dynamic>?) ?? <dynamic>[];
            final items = rows.map((row) {
              final rowMap = row as Map<String, dynamic>;
              return {
                'id': '',
                'productId': rowMap['modelid']?.toString() ?? '',
                'productTitle': '',
                'productImage': '',
                'price': rowMap['price'] ?? 0,
                'discount': 0,
                'quantity': rowMap['qty'] ?? 1,
                'size': rowMap['sizeid']?.toString(),
                'color': rowMap['colorid']?.toString(),
              };
            }).toList();

            return OrderModel.fromJson({
              'id': '',
              'userId': orderData['custid']?.toString() ?? '',
              'items': items,
              'subtotal': 0,
              'discount': 0,
              'shipping': 0,
              'tax': 0,
              'total': 0,
              'status': 'pending',
              'paymentMethod': 'cashOnDelivery',
              'paymentStatus': 'pending',
              'shippingAddress': {
                'fullName': orderData['name']?.toString() ?? '',
                'phone': orderData['phone']?.toString() ?? '',
                'address': orderData['address']?.toString() ?? '',
                'city': '',
                'state': '',
                'country': '',
                'postalCode': '',
              },
              'createdAt': DateTime.now().toIso8601String(),
            });
          }

          if (responseData.containsKey('order')) {
            return OrderModel.fromJson(responseData['order']);
          } else if (responseData.containsKey('data')) {
            return OrderModel.fromJson(responseData['data']);
          } else {
            return OrderModel.fromJson(responseData);
          }
        } else {
          throw ServerException(
            message: 'Invalid response format',
            code: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: 'Failed to create order: ${response.statusMessage}',
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
          message: 'Failed to create order: ${e.message}',
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
  Future<OrderModel> cancelOrder(String orderId) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.cancelOrder}/$orderId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: 'Failed to cancel order: ${response.statusMessage}',
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
          message: 'Failed to cancel order: ${e.message}',
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
  Future<Map<String, dynamic>> trackOrder(String orderId) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.trackOrder}/$orderId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw ServerException(
          message: 'Failed to track order: ${response.statusMessage}',
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
          message: 'Failed to track order: ${e.message}',
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
