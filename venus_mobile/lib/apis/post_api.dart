// lib/apis/post_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import 'endpoint.dart';

class PostApi {
  Future<List<Post>> getAllPosts() async {
    try {
      final response = await http.get(Uri.parse(Endpoint.getPosts));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Post.fromJson(data)).toList();
      } else {
        print('Failed to fetch posts: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error in PostApi getAllPosts: $e');
      throw Exception('Failed to load posts');
    }
  }
}
