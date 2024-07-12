import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mormovies/presentation/providers/providers.dart';
import 'package:mormovies/presentation/screens/screens.dart';
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
    final slideshowMovies = ref.watch(moviesSlideshowProvider);

    if (slideshowMovies.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(
        strokeWidth: 2,
      ));
    }

    return Column(
      children: [
        const CustomAppBar(),
        MoviesSlideshow(moviesList: slideshowMovies)
      ],
    );
  }
}
