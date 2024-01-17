class UpdateUserRequest {
  final String photo;
  final String name;
  final String contactNumber;

  UpdateUserRequest(
      {required this.name, required this.photo, required this.contactNumber});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile_image': photo,
      'contact_number': contactNumber,
    };
  }
}
