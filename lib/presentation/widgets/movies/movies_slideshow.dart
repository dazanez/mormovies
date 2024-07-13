import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:mormovies/domain/entities/movie.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> moviesList;

  const MoviesSlideshow({super.key, required this.moviesList});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.8,
        autoplay: true,
        autoplayDelay: 10000,
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary, color: colors.secondary)),
        itemCount: moviesList.length,
        itemBuilder: (context, index) => _Slide(movie: moviesList[index]),
      ),
    );
  }
}

final _slideDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
    ]);

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: _slideDecoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                movie.backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black12));
                  }
                  return FadeIn(child: child);
                },
                errorBuilder: (context, error, stackTrace) => const Center(child: Text('Ups, We had an error getting the image')),
              ),
              Positioned(
                height: 50,
                left: 0,
                right: 0,
                bottom: 0,
                child: _SlideText(movie.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _slideTextDecoration = BoxDecoration(
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
  gradient: LinearGradient(
      colors: [Colors.black12, Colors.black38, Colors.black45],
      stops: [0.1, 0.5, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter),
);

class _SlideText extends StatelessWidget {
  final String title;

  const _SlideText(this.title);

  static const titleStyle = TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w300);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _slideTextDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            title,
            style: titleStyle,
          ),
        ),
      ),
    );
  }
}
