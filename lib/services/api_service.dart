import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/genre.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<Movie>> fetchPopularMovies() async {
  final response = await http.get(Uri.parse('${Constants.baseUrl}/movie/popular?api_key=6b221f6301548cba3a9b5c2ebb2946cb&language=th'));
  
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body)['results'];
    return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
  } else {
    throw Exception('Failed to load popular movies');
  }
}

  Future<List<Movie>> fetchMoviesByGenre(int genreId) async {
  final response = await http.get(Uri.parse('${Constants.baseUrl}/discover/movie?api_key=6b221f6301548cba3a9b5c2ebb2946cb&with_genres=$genreId&language=th'));
  
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body)['results'];
    return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
  } else {
    throw Exception('Failed to load movies by genre');
  }
}

  Future<List<Genre>> fetchGenres() async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/genre/movie/list?api_key=6b221f6301548cba3a9b5c2ebb2946cb&language=th'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['genres'];
      return jsonResponse.map((genre) => Genre.fromJson(genre)).toList();
    } else {
      print('Error: ${response.statusCode} ${response.body}');
      throw Exception('Failed to load genres');
    }
  }
}
