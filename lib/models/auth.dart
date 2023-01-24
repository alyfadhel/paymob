class Auth {
  final Profile profile;
  final String token;

  Auth({
    required this.profile,
    required this.token,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      profile: Profile.fromJson(json['profile']),
      token: json['token'],
    );
  }
}

class Profile {
  final int id;
  final User user;
  final List<String> phones;

  Profile({
    required this.id,
    required this.user,
    required this.phones,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      user: User.fromJson(json['user']),
      phones: List<String>.from((json['phones'] as List).map((e) => e)),
    );
  }
}

class User {
  final int id;
  final String userName;
  final String firstName;
  final String lastName;
  final String email;

  User({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }
}
