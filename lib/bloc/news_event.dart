import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchNews extends NewsEvent {
  final int page;
  FetchNews({this.page = 1});
}
