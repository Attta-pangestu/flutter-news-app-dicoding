// Suggested code may be subject to a license. Learn more: ~LicenseLog:1543395822.
import 'package:flutter/material.dart';
import 'package:myapp/article_web_view.dart';
import 'package:myapp/model/article.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;
  static const routeName = '/article_detail';
  const ArticleDetailPage({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(article.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(article.urlToImage),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.description),
                    const Divider(color: Colors.grey),
                    Text(
                      article.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Text('Date : ${article.publishedAt}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Author : ${article.author}'),
                    const Divider(color: Colors.grey),
                    Text(article.content, style: const TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 10, d
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ArticleWebView.routeName,
                              arguments: article.url);
                        },
                        child: const Text('Read More'))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
