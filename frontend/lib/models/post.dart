// Postモデル作成
class Post {
  final int id;
  final int userId;
  final String text;
  final String imageUrl;
  final String createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.text,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      text: json['text'],
      imageUrl: json['image_url'] ?? '',
      createdAt: json['created_at'],
    );
  }
}
