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

    for (final movieProvider in allMoviesProviders) {
      ref.read(movieProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    final fullScreenLoader = FullScreenLoader();

    final slideshowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return Visibility(
      replacement: fullScreenLoader,
      visible: !initialLoading,
      child: CustomScrollView(
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
                        movies: upcomingMovies,
                        title: 'Upcoming',
                        subtitle: 'Soon',
                        loadNextPage: () => ref
                            .read(upcomingMoviesProvider.notifier)
                            .loadNextPage(),
                      ),
                      MoviesHorizontalListView(
                        movies: popularMovies,
                        title: 'Popular',
                        // subtitle: 'Now',
                        loadNextPage: () => ref
                            .read(popularMoviesProvider.notifier)
                            .loadNextPage(),
                      ),
                      MoviesHorizontalListView(
                        movies: topRatedMovies,
                        title: 'Top rated',
                        subtitle: 'The bests 🔥',
                        loadNextPage: () => ref
                            .read(topRatedMoviesProvider.notifier)
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
      ),
    );
  }
}
