import 'package:uuid/uuid.dart'; // Make sure uuid is in your pubspec.yaml

enum FarmingGuidePostType {
  video,
  image,
  text,
}

class FarmingGuidePostModel {
  final String id;
  final String title;
  final String content;
  final String? imageUrl; // Optional image/video thumbnail
  final FarmingGuidePostType type;
  final String? videoUrl; // For future video playback

  FarmingGuidePostModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    this.type = FarmingGuidePostType.text,
    this.videoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'type': type.name, // Store enum as string
      'videoUrl': videoUrl,
    };
  }

  factory FarmingGuidePostModel.fromMap(Map<String, dynamic> map) {
    return FarmingGuidePostModel(
      id: map['id'] as String? ?? const Uuid().v4(),
      title: map['title'] as String? ?? 'No Title',
      content: map['content'] as String? ?? '',
      imageUrl: map['imageUrl'] as String?,
      type: FarmingGuidePostType.values.firstWhere(
        (e) => e.name == (map['type'] as String?),
        orElse: () => FarmingGuidePostType.text,
      ),
      videoUrl: map['videoUrl'] as String?,
    );
  }
}
