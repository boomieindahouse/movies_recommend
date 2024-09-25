import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_card.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList({required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(movie: movies[index]);
      },
    );
  }
}
