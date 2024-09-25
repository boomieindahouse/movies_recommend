import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../screens/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard({required this.movie});

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
      child: Card(
        elevation: 0, // ลบเงาของ Card
        color: Colors.transparent, // ทำให้ Card โปร่งใส
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 1), // กำหนดสีและความหนาของ border
          borderRadius: BorderRadius.circular(8), // กำหนดความโค้งของมุม
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 199, 141, 140).withOpacity(0.1), // กำหนดสีพื้นหลังโปร่งใส
            borderRadius: BorderRadius.circular(2), // กำหนดความโค้งของมุม
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 110,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: TextStyle(fontFamily: 'ThaiFont', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
