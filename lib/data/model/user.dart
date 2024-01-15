class User {
  late final String name;
  final String email;
  String? photo;
  late final String contact_number;

  User({
    required this.name,
    required this.email,
    required this.photo,
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
      photo: json['photo'],
    );
  }
}
