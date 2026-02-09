import '../../domain/entities/order.dart';
import 'order_item_model.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.items,
    required super.subtotal,
    required super.discount,
    required super.shipping,
    required super.tax,
    required super.total,
    required super.status,
    required super.paymentMethod,
    required super.paymentStatus,
    required super.shippingAddress,
    required super.createdAt,
    super.updatedAt,
    super.trackingNumber,
    super.notes,
  });
  
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? json['user_id']?.toString() ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      shipping: (json['shipping'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      status: _parseOrderStatus(json['status']?.toString()),
      paymentMethod: _parsePaymentMethod(json['paymentMethod']?.toString() ?? json['payment_method']?.toString()),
      paymentStatus: _parsePaymentStatus(json['paymentStatus']?.toString() ?? json['payment_status']?.toString()),
      shippingAddress: ShippingAddressModel.fromJson(
        json['shippingAddress'] as Map<String, dynamic>? ?? json['shipping_address'] as Map<String, dynamic>? ?? {},
      ),
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? json['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: json['updatedAt'] != null || json['updated_at'] != null
          ? DateTime.tryParse(json['updatedAt']?.toString() ?? json['updated_at']?.toString() ?? '')
          : null,
      trackingNumber: json['trackingNumber']?.toString() ?? json['tracking_number']?.toString(),
      notes: json['notes']?.toString(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((e) => (e as OrderItemModel).toJson()).toList(),
      'subtotal': subtotal,
      'discount': discount,
      'shipping': shipping,
      'tax': tax,
      'total': total,
      'status': _orderStatusToString(status),
      'paymentMethod': _paymentMethodToString(paymentMethod),
      'paymentStatus': _paymentStatusToString(paymentStatus),
      'shippingAddress': (shippingAddress as ShippingAddressModel).toJson(),
      'createdAt': createdAt.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      if (trackingNumber != null) 'trackingNumber': trackingNumber,
      if (notes != null) 'notes': notes,
    };
  }
  
  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      userId: order.userId,
      items: order.items,
      subtotal: order.subtotal,
      discount: order.discount,
      shipping: order.shipping,
      tax: order.tax,
      total: order.total,
      status: order.status,
      paymentMethod: order.paymentMethod,
      paymentStatus: order.paymentStatus,
      shippingAddress: order.shippingAddress,
      createdAt: order.createdAt,
      updatedAt: order.updatedAt,
      trackingNumber: order.trackingNumber,
      notes: order.notes,
    );
  }
  
  static OrderStatus _parseOrderStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'processing':
        return OrderStatus.processing;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'refunded':
        return OrderStatus.refunded;
      default:
        return OrderStatus.pending;
    }
  }
  
  static String _orderStatusToString(OrderStatus status) {
    return status.toString().split('.').last;
  }
  
  static PaymentMethod _parsePaymentMethod(String? method) {
    switch (method?.toLowerCase()) {
      case 'creditcard':
      case 'credit_card':
        return PaymentMethod.creditCard;
      case 'debitcard':
      case 'debit_card':
        return PaymentMethod.debitCard;
      case 'paypal':
        return PaymentMethod.paypal;
      case 'applepay':
      case 'apple_pay':
        return PaymentMethod.applePay;
      case 'googlepay':
      case 'google_pay':
        return PaymentMethod.googlePay;
      default:
        return PaymentMethod.cashOnDelivery;
    }
  }
  
  static String _paymentMethodToString(PaymentMethod method) {
    return method.toString().split('.').last;
  }
  
  static PaymentStatus _parsePaymentStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'paid':
        return PaymentStatus.paid;
      case 'failed':
        return PaymentStatus.failed;
      case 'refunded':
        return PaymentStatus.refunded;
      default:
        return PaymentStatus.pending;
    }
  }
  
  static String _paymentStatusToString(PaymentStatus status) {
    return status.toString().split('.').last;
  }
}

class ShippingAddressModel extends ShippingAddress {
  const ShippingAddressModel({
    required super.fullName,
    required super.phone,
    required super.addressLine1,
    super.addressLine2,
    required super.city,
    required super.state,
    required super.country,
    required super.postalCode,
  });
  
  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      fullName: json['fullName']?.toString() ?? json['full_name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      addressLine1: json['addressLine1']?.toString() ?? json['address_line_1']?.toString() ?? json['address']?.toString() ?? '',
      addressLine2: json['addressLine2']?.toString() ?? json['address_line_2']?.toString(),
      city: json['city']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      postalCode: json['postalCode']?.toString() ?? json['postal_code']?.toString() ?? json['zipCode']?.toString() ?? json['zip_code']?.toString() ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phone': phone,
      'addressLine1': addressLine1,
      if (addressLine2 != null) 'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
    };
  }
  
  factory ShippingAddressModel.fromEntity(ShippingAddress address) {
    return ShippingAddressModel(
      fullName: address.fullName,
      phone: address.phone,
      addressLine1: address.addressLine1,
      addressLine2: address.addressLine2,
      city: address.city,
      state: address.state,
      country: address.country,
      postalCode: address.postalCode,
    );
  }
}
