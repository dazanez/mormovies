import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:mormovies/config/helpers/human_formats.dart';
import 'package:mormovies/domain/entities/movie.dart';

class MoviesHorizontalListView extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListView({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (title != null || subtitle != null)
            _Title(title: title, subtitle: subtitle),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),

              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: movies[index]));
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final starIconData = movie.voteAverage > 6 ? Icons.star : Icons.star_half_outlined;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                fit: BoxFit.cover,
                movie.posterPath,
                width: 140,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ));
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          //* Title
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: 140,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle.titleSmall,
            ),
          ),
          //* Rating
          SizedBox(
            width: 140,
            child: Row(
              children: [
                Icon(starIconData, color: Colors.yellow.shade700,),
                const SizedBox(width: 5,),
                Text(movie.voteAverage.toStringAsFixed(2), style: textStyle.bodyMedium,),
                // const SizedBox(width: 10,),
                const Spacer(),
                Text('(${HumanFormats.number(movie.popularity)})', style: textStyle.bodyMedium,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 3),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          if (subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}
