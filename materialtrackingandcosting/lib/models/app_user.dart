enum UserRole { admin, operator }

class AppUser {
  final String uid;
  final String email;
  final String name;
  final UserRole role;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
  });

  factory AppUser.fromMap(Map<String, dynamic> data, String uid) {
    return AppUser(
      uid: uid,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      role: data['role'] == 'admin' ? UserRole.admin : UserRole.operator,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'role': role == UserRole.admin ? 'admin' : 'operator',
    };
  }
}
