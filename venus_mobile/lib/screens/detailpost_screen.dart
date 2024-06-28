import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/post.dart';

class DetailPostScreen extends StatefulWidget {
  static const String routeName = '/detailPost';
  final Post post;

  DetailPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  _DetailPostScreenState createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_getStyledHtmlContent(widget.post.content));
  }

  String _getStyledHtmlContent(String content) {
    String mobileFriendlyCss = """
    <style>
      body { font-family: 'Roboto', sans-serif; padding: 0 10px; margin: 0; }
      img { width: auto; max-width: 100%; height: auto; }
      img.full-width { width: 100%; }
      h1, h2, h3, h4, h5, h6 { font-size: 1.5em; }
      p { font-size: 1.2em; }
    </style>
    """;

    return """
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
      $mobileFriendlyCss
    </head>
    <body>
      $content
    </body>
    </html>
    """;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
