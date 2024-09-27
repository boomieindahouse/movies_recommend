import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api_service.dart';
import '../widgets/movie_list.dart';

class MovieListScreen extends StatelessWidget {
  final int genreId; 
  final String genreName; 

  MovieListScreen({required this.genreId, required this.genreName});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: Text(genreName), 
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, const Color.fromARGB(239, 92, 33, 33)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Movie>>(
          future: apiService.fetchMoviesByGenre(genreId), // เรียกใช้งาน API ดึงหนังตาม genreId
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No movies found for this genre.'));
            } else {
              return MovieList(movies: snapshot.data!); // เรียกใช้งาน MovieList สำหรับแสดงรายการหนัง
            }
          },
        ),
      ),
    );
  }
}
