import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_event.dart';
import 'package:news_app/bloc/news_state.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/repositories/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;
  int currentPage = 1;
  List<ArticleModel> allArticles = [];

  NewsBloc(this._newsRepository) : super(NewsLoading()) {
    on<FetchNews>(_onFetchNews);
  }

  void _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    try {
      final newArticles = await _newsRepository.fetchNews(page: event.page);

      if (event.page == 1) {
        allArticles.clear();
      }

      allArticles.addAll(newArticles);

      emit(NewsLoaded(allArticles, newArticles.isNotEmpty));

      currentPage++;
    } catch (e) {
      emit(NewsError());
    }
  }
}
