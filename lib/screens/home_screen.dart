import 'package:flutter/material.dart';
import '../widgets/movie_list.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import '../models/genre.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Genre>> genreFuture;
  late Future<List<Movie>> movieFuture;
  int? selectedGenreId;

  @override
  void initState() {
    super.initState();
    genreFuture = apiService.fetchGenres();
  }

  void updateMovies(int genreId) {
    setState(() {
      selectedGenreId = genreId;
      movieFuture = apiService.fetchMoviesByGenre(genreId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.dark().copyWith(
          secondary: Colors.deepPurpleAccent,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, const Color.fromARGB(239, 92, 33, 33)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Scaffold(
            backgroundColor:
                const Color.fromARGB(0, 0, 0, 0), // ทำให้พื้นหลังโปร่งใส
            appBar: AppBar(
              title: Text('ภาพยนตร์น่าดู',
                  style: TextStyle(fontFamily: 'ThaiFont')),
            ),
            body: Column(
              children: [
                // แสดงประเภทภาพยนตร์
                FutureBuilder<List<Genre>>(
                  future: genreFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0), // เพิ่ม padding ด้านบน
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              'Error: ${snapshot.error}')); // ใช้ Center widget
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0), // เพิ่ม padding ด้านบน
                        child: DropdownButton<int>(
                          hint: Text('เลือกประเภทหนัง',
                              style: TextStyle(
                                  fontFamily: 'ThaiFont', color: Colors.white)),
                          value: selectedGenreId,
                          onChanged: (int? newValue) {
                            updateMovies(newValue!);
                          },
                          items: snapshot.data!.map((genre) {
                            return DropdownMenuItem<int>(
                              value: genre.id,
                              child: Text(
                                genre.name,
                                style: TextStyle(fontFamily: 'ThaiFont'),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
                // แสดงภาพยนตร์ตามประเภทที่เลือก
                Expanded(
                  child: FutureBuilder<List<Movie>>(
                    future: selectedGenreId != null ? movieFuture : null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No movies found.'));
                      } else {
                        return MovieList(movies: snapshot.data!);
                      }
                    },
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
