import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:news_app/models/article_model.dart';

class NewsRepository {
  final Dio _dio = Dio();

  static const String apiKey = "cckewe3P06ngGING2dU1yJraYjRt9sWpyEjcBVer";
  static const String apiUrl =
      "https://api.thenewsapi.com/v1/news/top?api_token=$apiKey&locale=us&limit=20";

  Future<List<ArticleModel>> fetchNews({int page = 1}) async {
    
    var cacheBox = Hive.box('news_cache');
    String cacheKey = 'news_page_$page';

    if (cacheBox.containsKey(cacheKey)) {
      return ArticleModel.fromJsonList(cacheBox.get(cacheKey));
    }

    try {
      final response = await _dio.get('$apiUrl&page=$page');
      cacheBox.put(cacheKey, response.toString());
      return ArticleModel.fromJsonList(response.toString());
    } catch (e) {
      throw Exception("Failed to fetch news");
    }
  }
}