import 'package:flutter/material.dart';
import 'package:thebags_mobile/apis/ingredient_api.dart';
import 'package:thebags_mobile/apis/post_api.dart';
import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/models/ingredient.dart';
import 'package:thebags_mobile/models/post.dart';
import 'package:thebags_mobile/widgets/drawer.dart';
import 'package:thebags_mobile/widgets/navbar.dart';
import 'package:thebags_mobile/widgets/home/post_item.dart';
import 'package:thebags_mobile/widgets/home/ingredient_item.dart';
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import '../widgets/post_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Ingredient>> futureIngredients;
  late Future<List<Post>> futurePosts;
  final PostService _postService = PostService();
  List<Post> _posts = []; // Danh sách tất cả bài viết
  List<Post> _filteredPosts = []; // Danh sách bài viết sau khi lọc
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    futureIngredients = IngredientApi().getIngredients();
    futurePosts = _postService.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Home',
        searchBar: true,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: 'Home'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<Ingredient>>(
              future: futureIngredients,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: Text(
                          'Signature Food',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: ArgonColors.header,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Divider(
                        color: ArgonColors.muted,
                        thickness: 2.0,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return IngredientItem(
                            ingredient: snapshot.data![index],
                            onPressed: () {},
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
            FutureBuilder<List<Post>>(
              future: futurePosts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return PostItem(post: snapshot.data![index]);
                    },
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
