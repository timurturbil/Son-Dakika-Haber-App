import 'package:flutter/material.dart';
import 'package:t24haber/UI/custom_news_page.dart';

//Mainn
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'T24 Son Dakika Haberlerim',
      theme: new ThemeData(scaffoldBackgroundColor: Colors.grey[300]),
      home: CustomNewsPage(), 
    );
  }
}
