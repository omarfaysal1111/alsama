class AppConstants {
  // API Constants
  static const String baseUrl = 'https://api.alfaysalerp.com';
  static const String apiVersion = 'v1';
  static const String bearerToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbWEtZWMiLCJQcmV2WWVhciI6IjAiLCJuYmYiOjE3NzA2ODc1OTIsImV4cCI6MjA4NjIyMDM5MiwiaWF0IjoxNzcwNjg3NTkyfQ.bJ-r20R4sbfv7CpUkaVxStoOpNZjJtEpN3MIh_zjgik';

  // App Constants
  static const String appName = 'Alsama';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String cartDataKey = 'cart_data';
  static const String productsCacheKey = 'products_cache';

  // Timeouts
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache
  static const int cacheExpirationMinutes = 30;
}
