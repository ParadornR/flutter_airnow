class User {
  final String id;
  final String name;
  final String email;
  final String urlImage;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.urlImage,
    required this.phone,
  });

  // Method for converting JSON data from Firebase to User object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      urlImage: map['urlImage'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  // Method for converting User object to Map (to send data to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'urlImage': urlImage,
      'phone': phone,
    };
  }
}
