import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, const Color.fromARGB(239, 92, 33, 33)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // ทำให้พื้นหลังของ Scaffold โปร่งใส
        appBar: AppBar(
          title: Text(
            movie.title,
            style: TextStyle(
              fontFamily: 'ThaiFont',
              fontSize: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // แสดงภาพโปสเตอร์
                Center(
                  child: Container(
                    width: 200, // กำหนดความกว้างที่ต้องการ
                    height: 300, // กำหนดความสูงที่ต้องการ
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover, // ปรับขนาดภาพให้พอดีกับ Container
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // แสดงชื่อภาพยนตร์
                Text(
                  movie.title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ThaiFont',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
                // แสดงรายละเอียดภาพยนตร์
                Text(
                  movie.overview,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'ThaiFont',
                    color: Colors.grey,
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
