import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mormovies/presentation/providers/providers.dart';
import 'package:mormovies/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideshowMovies = ref.watch(moviesSlideshowProvider);

    if (slideshowMovies.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(
        strokeWidth: 2,
      ));
    }

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            title: CustomAppBar(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // const CustomAppBar(),
                    MoviesSlideshow(moviesList: slideshowMovies),
                    MoviesHorizontalListView(
                      movies: nowPlayingMovies,
                      title: 'Playing',
                      subtitle: 'In theaters',
                      loadNextPage: () => ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage(),
                    ),
                    MoviesHorizontalListView(
                      movies: nowPlayingMovies,
                      title: 'Best rated',
                      subtitle: 'Ever',
                      loadNextPage: () => ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage(),
                    ),
                    MoviesHorizontalListView(
                      movies: nowPlayingMovies,
                      title: 'Playing',
                      subtitle: 'In theaters',
                      loadNextPage: () => ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage(),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
