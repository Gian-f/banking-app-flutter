abstract class ProfileUIEvent {}

class FullNameChanged extends ProfileUIEvent {
  final String fullName;

  FullNameChanged(this.fullName);
}

class PhotoChanged extends ProfileUIEvent {
  final String photo;

  PhotoChanged(this.photo);
}

class PhoneChanged extends ProfileUIEvent {
  final String phone;

  PhoneChanged(this.phone);
}

class UpdateUserButtonClicked extends ProfileUIEvent {}
