import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/news_event.dart';
import 'package:news_app/bloc/news_state.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:news_app/screens/full_screen_image.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context
            .read<NewsBloc>()
            .add(FetchNews(page: context.read<NewsBloc>().currentPage));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News List"),
      ),
      body: BlocProvider(
        create: (context) => NewsBloc(NewsRepository())..add(FetchNews()),
        child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
          if (state is NewsLoading && state is! NewsLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewsLoaded) {
            return GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  // if (index == state.articles.length) {
                  //   return const Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // }
                  final article = state.articles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FullScreenImage(imageUrl: article.imageUrl)));
                    },
                    child: CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text("Failed To Load News"),
            );
          }
        }),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
