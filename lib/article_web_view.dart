import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatelessWidget {
  static const routeName = '/article_web_view';
  final String url;

  const ArticleWebView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final WebViewController webviewController = WebViewController()
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article WebView'),
      ),
      body: WebViewWidget(
        controller: webviewController,
      ),
    );
  }
}
