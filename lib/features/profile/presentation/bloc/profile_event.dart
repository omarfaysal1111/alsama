abstract class ProfileEvent {}

class GetProfileRequested extends ProfileEvent {}

class UpdateProfileRequested extends ProfileEvent {
  final String name;
  final String? phone;
  final String? avatar;
  
  UpdateProfileRequested({
    required this.name,
    this.phone,
    this.avatar,
  });
}

class ChangePasswordRequested extends ProfileEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  
  ChangePasswordRequested({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}

class UpdateEmailRequested extends ProfileEvent {
  final String newEmail;
  final String password;
  
  UpdateEmailRequested({
    required this.newEmail,
    required this.password,
  });
}

class DeleteAccountRequested extends ProfileEvent {
  final String password;
  final String reason;
  
  DeleteAccountRequested({
    required this.password,
    required this.reason,
  });
}

class UploadAvatarRequested extends ProfileEvent {
  final String imagePath;
  
  UploadAvatarRequested({required this.imagePath});
}

class GetNotificationSettingsRequested extends ProfileEvent {}

class UpdateNotificationSettingsRequested extends ProfileEvent {
  final bool emailNotifications;
  final bool pushNotifications;
  final bool smsNotifications;
  
  UpdateNotificationSettingsRequested({
    required this.emailNotifications,
    required this.pushNotifications,
    required this.smsNotifications,
  });
}

class GetPrivacySettingsRequested extends ProfileEvent {}

class UpdatePrivacySettingsRequested extends ProfileEvent {
  final bool profileVisibility;
  final bool orderHistoryVisibility;
  final bool dataSharing;
  
  UpdatePrivacySettingsRequested({
    required this.profileVisibility,
    required this.orderHistoryVisibility,
    required this.dataSharing,
  });
}

class RefreshProfileRequested extends ProfileEvent {}
