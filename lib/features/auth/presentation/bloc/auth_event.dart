abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  
  LoginRequested({
    required this.email,
    required this.password,
  });
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String? phone;
  
  RegisterRequested({
    required this.email,
    required this.password,
    required this.name,
    this.phone,
  });
}

class LogoutRequested extends AuthEvent {}

class GetCurrentUserRequested extends AuthEvent {}

class ForgotPasswordRequested extends AuthEvent {
  final String email;
  
  ForgotPasswordRequested({required this.email});
}

class ResetPasswordRequested extends AuthEvent {
  final String token;
  final String newPassword;
  
  ResetPasswordRequested({
    required this.token,
    required this.newPassword,
  });
}

class AuthStatusChanged extends AuthEvent {
  final bool isAuthenticated;
  
  AuthStatusChanged({required this.isAuthenticated});
}
