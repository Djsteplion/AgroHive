import 'package:uuid/uuid.dart'; // Make sure uuid is in your pubspec.yaml

class CommentModel {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String content;
  int likes;
  bool isLiked;
  final DateTime timestamp;

  CommentModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.content,
    this.likes = 0,
    this.isLiked = false,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'content': content,
      'likes': likes,
      'isLiked': isLiked,
      'timestamp': timestamp.toIso8601String(), // Store DateTime as ISO 8601 string
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] as String? ?? const Uuid().v4(), // Generate new ID if missing
      userId: map['userId'] as String? ?? '',
      userName: map['userName'] as String? ?? 'Unknown User',
      userAvatar: map['userAvatar'] as String? ?? '',
      content: map['content'] as String? ?? '',
      likes: map['likes'] as int? ?? 0,
      isLiked: map['isLiked'] as bool? ?? false,
      timestamp: DateTime.tryParse(map['timestamp'] as String? ?? '') ?? DateTime.now(), // Parse string back to DateTime
    );
  }
}
