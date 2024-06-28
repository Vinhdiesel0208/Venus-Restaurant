import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/post.dart';
import '../screens/detailpost_screen.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({Key? key, required this.post}) : super(key: key);

  Widget _buildImage(String imageUrl) {
    // Sử dụng SizedBox để giới hạn kích thước hình ảnh
    return SizedBox(
      height: 250, // Giới hạn chiều cao của hình ảnh
      width: double.infinity, // Chiều rộng tối đa theo chiều rộng của Card
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit
            .cover, // Dùng BoxFit.cover để hình ảnh phủ kín khung mà không làm mất tỷ lệ
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  String _stripHtmlIfNeeded(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    String plainTextContent = _stripHtmlIfNeeded(post.content);
    return Card(
      child: Column(
        children: <Widget>[
          if (post.imageUrl.startsWith('http')) ...[
            _buildImage(post.imageUrl)
          ] else ...[
            // Xử lý cho base64 hoặc các trường hợp khác
          ],
          ListTile(
            title: Text(post.title,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Điều chỉnh kích thước font nếu cần
                )),
            subtitle: Text(plainTextContent,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  fontSize: 14, // Điều chỉnh kích thước font nếu cần
                )),
          ),
          TextButton(
            child: Text('Read More'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPostScreen(post: post)),
            ),
          ),
        ],
      ),
    );
  }
}
