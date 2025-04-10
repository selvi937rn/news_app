import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/response_articles.dart';

class Client {
  static Future<List<Article>> fetchArticle() async {
    const url =
      "https://newsapi.org/v2/everything?q=Indonesia&sources?country=id&apiKey=0693d729a5ae44a5bab8245a27c27589";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // if server did return a 200 OK response, then parse the JSON.
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      ResponseArticles responseArticles = 
        ResponseArticles.fromJson(responseBody);
      return responseArticles.articles;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load article');
    }
  }
}