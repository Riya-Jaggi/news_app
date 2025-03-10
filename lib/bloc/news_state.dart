import 'package:equatable/equatable.dart';
import 'package:news_app/models/article_model.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<ArticleModel> articles;
  final bool hasMore;

  NewsLoaded(this.articles, this.hasMore);

  @override
  List<Object> get props => [articles, hasMore];
}

class NewsError extends NewsState {}
