import 'package:flutter/material.dart';
import '../widgets/movie_item.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import '../models/genre.dart';
import 'movie_list_screen.dart'; // Import MovieListScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Genre>> genreFuture;
  late Future<List<Movie>> popularMoviesFuture; // ดึงหนังยอดนิยม

  @override
  void initState() {
    super.initState();
    genreFuture = apiService.fetchGenres();
    popularMoviesFuture = apiService.fetchPopularMovies(); // ดึงหนังยอดนิยม
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
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            body: Column(
              children: [
                // Text ตรงกลางด้านบน
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: Text(
                    'Movies For You',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(212, 176, 18, 18),
                      fontFamily: 'ThaiFont',
                    ),
                  ),
                ),
                // แสดงประเภทภาพยนตร์
                FutureBuilder<List<Genre>>(
                  future: genreFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: DropdownButton<int>(
                          hint: Text('เลือกประเภทหนัง',
                              style: TextStyle(fontFamily: 'ThaiFont', color: Colors.white)),
                          onChanged: (int? newValue) {
                            if (newValue != null) {
                              final selectedGenre = snapshot.data!.firstWhere((genre) => genre.id == newValue);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieListScreen(
                                    genreId: newValue, // ส่ง genreId
                                    genreName: selectedGenre.name, // ส่งชื่อประเภทหนัง
                                  ),
                                ),
                              );
                            }
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
                SizedBox(height: 100), // เพิ่มระยะห่าง
                // แสดงหนังยอดนิยมเป็น Carousel ด้านล่าง
                FutureBuilder<List<Movie>>(
                  future: popularMoviesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No popular movies found.'));
                    } else {
                      return Container(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Movie movie = snapshot.data![index];
                            return MovieItem(movie: movie); // เรียกใช้งาน MovieItem
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
