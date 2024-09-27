import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../screens/movie_detail_screen.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // โปสเตอร์หนัง
            Container(
              width: 150,
              height: 210,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.0),
            // ชื่อหนังตรงกลางด้านล่างของโปสเตอร์
            Text(
              movie.title,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'ThaiFont',
                color: const Color.fromARGB(255, 218, 218, 218),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
