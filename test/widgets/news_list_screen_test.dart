import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/news_state.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/screens/news_list_screen.dart';

import '../mocks/mock_news_bloc.dart';

void main() {
  late MockNewsBloc mockNewsBloc;

  setUp(() {
    mockNewsBloc = MockNewsBloc();
  });

  tearDown(() {
    mockNewsBloc.close();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<NewsBloc>.value(
        value: mockNewsBloc,
        child: const NewsListScreen(),
      ),
    );
  }

  testWidgets(
      "NewsListScreen shows loading indicator when state is NewsLoading",
      (WidgetTester tester) async {
    final articles = [
      ArticleModel(
          imageUrl: "https://example.com/image.jpg", title: "Test News")
    ];
    when(() => mockNewsBloc.state).thenReturn(NewsLoaded(articles, false));

    await tester.pumpWidget(createTestWidget());
    await tester.pump();

    expect(find.text("Test News"), findsOneWidget);
  });
}
