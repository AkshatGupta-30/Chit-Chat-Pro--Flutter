import 'package:chit_chat_pro/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chit Chat Pro',
      theme: ThemeData(
        fontFamily: 'LovelyMamma',
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF051811),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFFe1e1e1), fontSize: 25,
            fontWeight: FontWeight.w700, fontFamily: 'LovelyMamma',
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          hintStyle: TextStyle(color: Color(0xFF6c757d), fontSize: 21),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF1b4332), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF2d6a4f), width: 2),
          ),
        )
      ),
      home: HomePage()
    );
  }
}
