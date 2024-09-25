import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ภาพยนตร์น่าดู',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'ThaiFont'),
      home: HomeScreen(),
    );
  }
}
