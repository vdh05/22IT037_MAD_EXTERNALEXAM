enum UserRole { admin, operator }

class UserModel {
  final String id;
  final String username;
  final String email;
  final UserRole role;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  // Check if user has admin access
  bool get isAdmin => role == UserRole.admin;
  
  // Check if user has operator access
  bool get isOperator => role == UserRole.operator;

  // Create from map (for database)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] == 'admin' ? UserRole.admin : UserRole.operator,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role == UserRole.admin ? 'admin' : 'operator',
    };
  }
}
