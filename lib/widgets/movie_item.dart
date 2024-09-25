import 'package:flutter/material.dart';
import '../models/movie.dart'; // ตรวจสอบให้แน่ใจว่าได้ import โมเดล Movie ด้วย

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigate ไปยังหน้ารายละเอียดหนัง
              // Navigator.push(...);
            },
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              fit: BoxFit.cover,
              height: 240,
            ),
          ),
          SizedBox(height: 10),
          Text(
            movie.title,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'ThaiFont',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
