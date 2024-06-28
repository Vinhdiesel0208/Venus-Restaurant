class Post {
  final int id;
  final String title;
  final String imageUrl;
  final String content;
  final DateTime publishedAt;

  Post({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.publishedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['image'] ?? '',
      content: json['content'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Tạo một getter mới cho contentSnippet
  String get contentSnippet {
    // Ví dụ: Lấy 100 ký tự đầu tiên của content
    return content.length > 100 ? '${content.substring(0, 100)}...' : content;
  }
}
