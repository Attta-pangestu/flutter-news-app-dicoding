import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/article_detail_screen.dart';
import 'package:myapp/article_web_view.dart';
import 'package:myapp/model/article.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: NewsListPage.routeName,
        routes: {
          NewsListPage.routeName: (context) => const NewsListPage(),
          ArticleDetailPage.routeName: (context) => ArticleDetailPage(
              article: ModalRoute.of(context)?.settings.arguments as Article
          ),
          ArticleWebView.routeName : (context) => ArticleWebView(
            url: ModalRoute.of(context)?.settings.arguments as String
          )
              
        });
  }
}

class NewsListPage extends StatelessWidget {
  static const routeName = '/article_list';
  const NewsListPage({super.key});

  List<Article> parseArticles(String? json) {
    if (json == null) {
      return [];
    }
    final List parsed = jsonDecode(json) as List;
    return parsed
        .map((json) => Article.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Widget _buildArticleItem(BuildContext context, Article article) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, ArticleDetailPage.routeName,
            arguments: article);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Image.network(
        article.urlToImage,
        width: 100,
        height: 200,
        errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
      ),
      title: Text(article.title),
      subtitle: Text(article.author),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News App')),
      body: FutureBuilder<String>(
        future:
            DefaultAssetBundle.of(context).loadString('assets/articles.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            final List<Article> articles = parseArticles(snapshot.data);
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return _buildArticleItem(context, articles[index]);
              },
            );
          }
        },
      ),
    );
  }
}
