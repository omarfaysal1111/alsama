import 'package:equatable/equatable.dart';
import 'user.dart';

class AuthResult extends Equatable {
  final User user;
  final String token;
  final String? refreshToken;

  const AuthResult({
    required this.user,
    required this.token,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [user, token, refreshToken];
}
