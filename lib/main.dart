import 'package:fetch_api/fetch.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Color.fromARGB(255, 187, 154, 104),
        scaffoldBackgroundColor: Colors.grey[100],
        cardColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: PostListScreen(),
    );
  }
}
