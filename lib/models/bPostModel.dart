import 'package:uuid/uuid.dart';
import 'comment_model.dart';

class PostModel {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String content;
  final String imageUrl;
  int likes;
  bool isLiked;
  List<CommentModel> comments;
  final DateTime timestamp;
  int downloads;    // ✨ NEW: Download count ✨
  bool isDownloaded; // ✨ NEW: Download status ✨
  int bookmarks;    // ✨ NEW: Bookmark count ✨
  bool isBookmarked; // ✨ NEW: Bookmark status ✨

  PostModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.imageUrl,
    this.likes = 0,
    this.isLiked = false,
    List<CommentModel>? comments,
    required this.timestamp,
    this.downloads = 0,    // ✨ NEW: Default download count ✨
    this.isDownloaded = false, // ✨ NEW: Default download status ✨
    this.bookmarks = 0,    // ✨ NEW: Default bookmark count ✨
    this.isBookmarked = false, // ✨ NEW: Default bookmark status ✨
  }) : comments = comments ?? [];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'content': content,
      'imageUrl': imageUrl,
      'likes': likes,
      'isLiked': isLiked,
      'comments': comments.map((c) => c.toMap()).toList(),
      'timestamp': timestamp.toIso8601String(),
      'downloads': downloads,      // ✨ NEW: Serialize downloads ✨
      'isDownloaded': isDownloaded, // ✨ NEW: Serialize isDownloaded ✨
      'bookmarks': bookmarks,      // ✨ NEW: Serialize bookmarks ✨
      'isBookmarked': isBookmarked, // ✨ NEW: Serialize isBookmarked ✨
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String? ?? const Uuid().v4(),
      userId: map['userId'] as String? ?? '',
      userName: map['userName'] as String? ?? 'Unknown User',
      userAvatar: map['userAvatar'] as String? ?? '',
      content: map['content'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      likes: map['likes'] as int? ?? 0,
      isLiked: map['isLiked'] as bool? ?? false,
      comments: (map['comments'] as List<dynamic>?)
              ?.map((cMap) => CommentModel.fromMap(cMap as Map<String, dynamic>))
              .toList() ??
          [],
      timestamp: DateTime.tryParse(map['timestamp'] as String? ?? '') ?? DateTime.now(),
      downloads: map['downloads'] as int? ?? 0,          // ✨ NEW: Deserialize downloads ✨
      isDownloaded: map['isDownloaded'] as bool? ?? false, // ✨ NEW: Deserialize isDownloaded ✨
      bookmarks: map['bookmarks'] as int? ?? 0,          // ✨ NEW: Deserialize bookmarks ✨
      isBookmarked: map['isBookmarked'] as bool? ?? false, // ✨ NEW: Deserialize isBookmarked ✨
    );
  }
}
