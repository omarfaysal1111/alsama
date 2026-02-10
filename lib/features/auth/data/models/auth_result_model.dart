import '../../domain/entities/auth_result.dart';
import 'user_model.dart';

class AuthResultModel extends AuthResult {
  const AuthResultModel({required super.user, required super.token});

  factory AuthResultModel.fromLoginResponse(Map<String, dynamic> json) {
    return AuthResultModel(
      user: UserModel.fromJson(json),
      // API login response does not include token; keep app session key from user id
      token: json['id']?.toString() ?? '',
    );
  }

  factory AuthResultModel.fromRegisterResponse({
    required UserModel user,
  }) {
    return AuthResultModel(
      user: user,
      token: user.id,
    );
  }

  factory AuthResultModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id') || json.containsKey('email')) {
      return AuthResultModel.fromLoginResponse(json);
    }

    return AuthResultModel(
      user: UserModel.fromJson(
        json['user'] != null ? json['user'] as Map<String, dynamic> : json,
      ),
      token: json['token'] as String? ?? json['access_token'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': (user as UserModel).toJson(), 'token': token};
  }
}
