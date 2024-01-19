class User {
  late final String name;
  final String email;
  String? profile_image;
  late final String contact_number;

  User({
    required this.name,
    required this.email,
    required this.profile_image,
    required this.contact_number,
  });

  bool get isEmpty =>
      name == "Carregando..." &&
      email == "Carregando..." &&
      contact_number == "Carregando...";

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      contact_number: json['contact_number'],
      profile_image: json['profile_image'],
    );
  }
}
