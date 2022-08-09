import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:son_dakika_haber/UI/custom_news_page.dart';

//Main
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new MyApp());
    });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Son Dakika Haberlerim',
      theme: new ThemeData(scaffoldBackgroundColor: Colors.grey[300]),
      home: CustomNewsPage(),
    );
  }
}
