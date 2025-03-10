import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/news_event.dart';
import 'package:news_app/bloc/news_state.dart';
import 'package:news_app/models/article_model.dart';

import '../mocks/mock_news_repository.dart';

@GenerateMocks([Dio])
void main() {
  late NewsBloc newsBloc;
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    newsBloc = NewsBloc(mockNewsRepository);
  });

  tearDown(() {
    newsBloc.close();
  });

  group("News Bloc Test", () {
    blocTest<NewsBloc, NewsState>(
        "emits NewsLoading and NewsLoaded when fetchnews is added and API succeeds",
        build: () {
          when(() => mockNewsRepository.fetchNews()).thenAnswer(
              (answer) async => [
                    ArticleModel(
                        imageUrl: 'https://example.com/image.jpg',
                        title: 'Test News')
                  ]);

          return newsBloc;
        },
        act: (bloc) => bloc.add(FetchNews()),
        expect: () => [NewsLoading(), isA<NewsLoaded>]);

    blocTest<NewsBloc, NewsState>(
        "emits NewsLoading NewsError when fetchnews is added and API falls",
        build: () {
          when(() => mockNewsRepository.fetchNews())
              .thenThrow(Exception("API Error"));

          return newsBloc;
        },
        act: (bloc) => bloc.add(FetchNews()),
        expect: () => [NewsLoading(), isA<NewsError>()]);
  });
}
