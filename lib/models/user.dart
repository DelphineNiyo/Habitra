class User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String createdAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        username: json['username'],
        email: json['email'],
        createdAt: json['created_at'],
      );
}
