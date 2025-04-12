import 'package:flutter/material.dart';
import 'package:news_app/client.dart';
import 'package:news_app/detail_news_page.dart';
import 'package:news_app/response_articles.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late List<Article> listArticle;
  bool isLoading = false;

  Future getListArticle() async {
    setState(() {
      isLoading = true;
    });

    listArticle = await Client.fetchArticle();
    print(listArticle);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    listArticle = [];
    getListArticle();
  }

  String formatDate(String? dateStr) {
    try {
      final date = DateTime.parse(dateStr ?? '');
      return "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return 'Unknown Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "The News",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : listArticle.isEmpty
              ? const Center(child: Text("Tidak ada data"))
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: listArticle.length,
                  itemBuilder: (context, index) {
                    final article = listArticle[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailNewsPage(article: article),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: theme.cardTheme.shadowColor ?? Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        margin: theme.cardTheme.margin ?? const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Image.network(
                                article.urlToImage ?? 'https://via.placeholder.com/150',
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 200),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                article.title,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.people_alt_outlined, size: 18),
                                      const SizedBox(width: 5),
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(maxWidth: 120), // batasi lebar author
                                        child: Text(
                                          article.author ?? 'Unknown',
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time_outlined, size: 13, color: Colors.grey),
                                      const SizedBox(width: 5),
                                      Text(
                                        article.publishedAt.toString(),
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
