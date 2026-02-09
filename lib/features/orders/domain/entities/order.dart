import 'order_item.dart';

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
  refunded
}

enum PaymentMethod {
  cashOnDelivery,
  creditCard,
  debitCard,
  paypal,
  applePay,
  googlePay
}

enum PaymentStatus {
  pending,
  paid,
  failed,
  refunded
}

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double subtotal;
  final double discount;
  final double shipping;
  final double tax;
  final double total;
  final OrderStatus status;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final ShippingAddress shippingAddress;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? trackingNumber;
  final String? notes;
  
  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.tax,
    required this.total,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.shippingAddress,
    required this.createdAt,
    this.updatedAt,
    this.trackingNumber,
    this.notes,
  });
  
  int get itemsCount => items.fold(0, (sum, item) => sum + item.quantity);
  bool get isPending => status == OrderStatus.pending;
  bool get isConfirmed => status == OrderStatus.confirmed;
  bool get isProcessing => status == OrderStatus.processing;
  bool get isShipped => status == OrderStatus.shipped;
  bool get isDelivered => status == OrderStatus.delivered;
  bool get isCancelled => status == OrderStatus.cancelled;
  bool get canBeCancelled => status == OrderStatus.pending || status == OrderStatus.confirmed;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Order && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}

class ShippingAddress {
  final String fullName;
  final String phone;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  
  const ShippingAddress({
    required this.fullName,
    required this.phone,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });
  
  String get fullAddress {
    final parts = [
      addressLine1,
      if (addressLine2 != null && addressLine2!.isNotEmpty) addressLine2,
      city,
      state,
      postalCode,
      country,
    ];
    return parts.join(', ');
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ShippingAddress &&
        other.fullName == fullName &&
        other.phone == phone &&
        other.addressLine1 == addressLine1 &&
        other.addressLine2 == addressLine2 &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.postalCode == postalCode;
  }
  
  @override
  int get hashCode => Object.hash(
        fullName,
        phone,
        addressLine1,
        addressLine2,
        city,
        state,
        country,
        postalCode,
      );
}
