// lib/services/post_service.dart

import '../apis/post_api.dart';
import '../models/post.dart';

class PostService {
  final PostApi _postApi = PostApi();

   Future<List<Post>> getAllPosts() async {
    try {
      List<Post> posts = await _postApi.getAllPosts();
      posts.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
      return posts;
    } catch (e) {
      print('Error fetching posts in PostService: $e');
      return [];
    }
  }
}
