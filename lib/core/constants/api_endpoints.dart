class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://api.alfaysalerp.com/fashion';
  // static const String baseUrl = 'http://192.168.1.27:7000/fashion';

  // Auth endpoints
  static const String login = '$baseUrl/clientlogin';
  static const String register = '$baseUrl/register';
  static const String logout = '$baseUrl/auth/logout';
  static const String refreshToken = '$baseUrl/auth/refresh';

  // Products endpoints
  static const String getAllProducts = '$baseUrl/getallProducts';
  static const String getProductById = '$baseUrl/product';
  static const String searchProducts = '$baseUrl/search';
  static const String getFeaturedProducts = '$baseUrl/featured';
  static const String getColorsByModel = '$baseUrl/getColors';
  static const String getSizes = '$baseUrl/getsizes';

  // Categories endpoints
  static const String getCategories = '$baseUrl/GetCatrgories';
  static const String getModelsByCategory = '$baseUrl/GetModels';

  // Cart endpoints
  static const String getCart = '$baseUrl/cart';
  static const String addToCart = '$baseUrl/cart/add';
  static const String updateCartItem = '$baseUrl/cart/update';
  static const String removeFromCart = '$baseUrl/cart/remove';
  static const String clearCart = '$baseUrl/cart/clear';

  // Orders endpoints
  static const String getOrders = '$baseUrl/orders';
  static const String createOrder = '$baseUrl/addorder';
  static const String getOrderById = '$baseUrl/orders';
  static const String cancelOrder = '$baseUrl/orders/cancel';
  static const String trackOrder = '$baseUrl/orders/track';

  // Profile endpoints
  static const String getProfile = '$baseUrl/profile';
  static const String updateProfile = '$baseUrl/profile/update';
  static const String changePassword = '$baseUrl/profile/change-password';
  static const String uploadAvatar = '$baseUrl/profile/avatar';
}
