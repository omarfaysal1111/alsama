class ServerException implements Exception {
  final String message;
  final int? code;
  
  const ServerException({
    required this.message,
    this.code,
  });
  
  @override
  String toString() => 'ServerException: $message (Code: $code)';
}

class NetworkException implements Exception {
  final String message;
  final int? code;
  
  const NetworkException({
    required this.message,
    this.code,
  });
  
  @override
  String toString() => 'NetworkException: $message (Code: $code)';
}

class CacheException implements Exception {
  final String message;
  final int? code;
  
  const CacheException({
    required this.message,
    this.code,
  });
  
  @override
  String toString() => 'CacheException: $message (Code: $code)';
}

class ValidationException implements Exception {
  final String message;
  final int? code;
  
  const ValidationException({
    required this.message,
    this.code,
  });
  
  @override
  String toString() => 'ValidationException: $message (Code: $code)';
}

class AuthException implements Exception {
  final String message;
  final int? code;
  
  const AuthException({
    required this.message,
    this.code,
  });
  
  @override
  String toString() => 'AuthException: $message (Code: $code)';
}

class UnknownException implements Exception {
  final String message;
  final int? code;
  
  const UnknownException({
    required this.message,
    this.code,
  });
  
  @override
  String toString() => 'UnknownException: $message (Code: $code)';
}
