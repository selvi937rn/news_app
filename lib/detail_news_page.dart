import 'package:flutter/material.dart';
import 'package:news_app/response_articles.dart';

class DetailNewsPage extends StatelessWidget {
  final Article article;

  const DetailNewsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: ListView(
        children: [
          Image.network(
            article.urlToImage ?? 'https://via.placeholder.com/400x200.png?text=No+Image',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              article.title,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const Icon(Icons.people_alt_outlined,
                    size: 18),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    article.author ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              article.description ?? "Tidak ada deskripsi.",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
