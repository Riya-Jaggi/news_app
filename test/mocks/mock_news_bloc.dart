import 'package:bloc_test/bloc_test.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/news_event.dart';
import 'package:news_app/bloc/news_state.dart';

class MockNewsBloc extends MockBloc<NewsEvent, NewsState> implements NewsBloc{}