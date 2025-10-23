class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://api.alfaysalerp.com';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Products endpoints
  static const String getAllProducts = '$baseUrl/fashion/getallProducts';
  static const String getProductById = '/fashion/product';
  static const String searchProducts = '/fashion/search';
  static const String getFeaturedProducts = '/fashion/featured';
  static const String getCategories = '/fashion/categories';

  // Cart endpoints
  static const String getCart = '/cart';
  static const String addToCart = '/cart/add';
  static const String updateCartItem = '/cart/update';
  static const String removeFromCart = '/cart/remove';
  static const String clearCart = '/cart/clear';

  // Orders endpoints
  static const String getOrders = '/orders';
  static const String createOrder = '/orders/create';
  static const String getOrderById = '/orders';
  static const String cancelOrder = '/orders/cancel';
  static const String trackOrder = '/orders/track';

  // Profile endpoints
  static const String getProfile = '/profile';
  static const String updateProfile = '/profile/update';
  static const String changePassword = '/profile/change-password';
  static const String uploadAvatar = '/profile/avatar';
}
