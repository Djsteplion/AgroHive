import 'package:uuid/uuid.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final String avatarUrl;
  final String password; // WARNING: Storing plain text password for local demo purposes - NOT SECURE FOR PRODUCTION
  List<String> followedUserIds; // ✨ NEW: List of user IDs this user follows ✨

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.avatarUrl,
    required this.password,
    List<String>? followedUserIds, // ✨ NEW: Optional in constructor ✨
  }) : followedUserIds = followedUserIds ?? [];

  // CRITICAL SECURITY WARNING: In a real app, passwords should NEVER be stored
  // or transmitted in plain text. They should be securely hashed.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'password': password,
      'followedUserIds': followedUserIds, // ✨ NEW: Serialize followedUserIds ✨
    };
  }

  // CRITICAL SECURITY WARNING: In a real app, passwords should NEVER be loaded
  // or used in plain text from storage.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String? ?? const Uuid().v4(),
      username: map['username'] as String? ?? '',
      email: map['email'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      avatarUrl: map['avatarUrl'] as String? ?? '',
      password: map['password'] as String? ?? '',
      // ✨ NEW: Deserialize followedUserIds ✨
      followedUserIds: (map['followedUserIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }
}
