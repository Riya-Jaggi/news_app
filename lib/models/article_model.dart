import 'dart:convert';

class ArticleModel {
  final String title;
  final String imageUrl;

  ArticleModel({required this.imageUrl, required this.title});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        imageUrl: json['image_url'] ?? '', title: json['title'] ?? '');
  }


  static List<ArticleModel> fromJsonList(String responseBody) {
    final data = json.decode(responseBody);
    return (data['data'] as List).map((e) => ArticleModel.fromJson(e)).toList();
  }
}
