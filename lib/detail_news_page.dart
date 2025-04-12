import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_app/response_articles.dart';

class DetailNewsPage extends StatelessWidget {
  final Article article;

  const DetailNewsPage({super.key, required this.article});

  Future<void> _launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            backgroundColor: Colors.red,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 16.0, end: 56.0),
              title: Text(
                article.title,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    article.urlToImage ?? 'https://via.placeholder.com/400x200.png?text=No+Image',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 200),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const Icon(Icons.people_alt_outlined, size: 18),
                      const SizedBox(width: 5),
                      Expanded(
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time_outlined, size: 13, color: Colors.grey,),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          article.publishedAt?.toString() ?? "",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    article.description ?? "Tidak ada deskripsi.",
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Text(
                //     article.content ?? "Tidak ada konten.",
                //     style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //   child: Row(
                //     children: [
                //       const Icon(Icons.link, size: 18),
                //       const SizedBox(width: 5),
                //       Expanded(
                //         child: GestureDetector(
                //           onTap: () {
                //             print("URL: ${article.url}");
                //             if (article.url != null) {
                //               _launchURL(article.url!);
                //             }
                //           },

                //           child: Text(
                //             article.url ?? 'No URL available',
                //             style: theme.textTheme.bodyMedium?.copyWith(
                //               color: Colors.blue,
                //               decoration: TextDecoration.underline,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
