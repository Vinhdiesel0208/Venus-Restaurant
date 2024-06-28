import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import '../widgets/post_item.dart'; 

class PostScreen extends StatefulWidget {
  static const String routeName = '/posts';

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostService _postService = PostService();
  List<Post> _posts = []; // Danh sách tất cả bài viết
  List<Post> _filteredPosts = []; // Danh sách bài viết sau khi lọc
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController(); // Controller cho TextField

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _searchController.addListener(_onSearchChanged); // Lắng nghe sự kiện thay đổi của TextField
  }

  void _fetchPosts() async {
    try {
      List<Post> posts = await _postService.getAllPosts();
      setState(() {
        _posts = posts;
        _filteredPosts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching posts: $e');
    }
  }

  // Hàm này được gọi mỗi khi có sự thay đổi trong TextField
  void _onSearchChanged() {
    setState(() {
      _filteredPosts = _posts.where((post) => 
        post.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        post.content.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField( // Thêm TextField vào AppBar
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search posts...",
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _filteredPosts.length, // Sử dụng _filteredPosts để hiển thị kết quả
            itemBuilder: (context, index) {
              return PostItem(post: _filteredPosts[index]);
            },
          ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose(); // Hủy Controller khi không cần thiết nữa
    super.dispose();
  }
}
