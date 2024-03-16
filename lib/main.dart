import 'package:chit_chat_pro/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';

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
        scaffoldBackgroundColor: Color(0xFF0F0F0F),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1b4332),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFFe1e1e1), fontSize: 25,
            fontWeight: FontWeight.w700, fontFamily: 'LovelyMamma',
          ),
        ),
        actionIconTheme: ActionIconThemeData(
          closeButtonIconBuilder: (context) {
            return CircleAvatar(
              radius: 16, backgroundColor: Colors.grey.shade300,
              child: Iconify(MaterialSymbols.close_rounded),
            );
          },
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          hintStyle: TextStyle(color: Color(0xFFadb5bd), fontSize: 21),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF40916c), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF52b788), width: 2),
          ),
          suffixIconColor: Colors.black
        ),
        primaryTextTheme: TextTheme(
          displaySmall: TextStyle()
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            fixedSize: MaterialStatePropertyAll(Size(double.maxFinite, 20)),
            backgroundColor: MaterialStatePropertyAll(Color(0xFF2d6a4f)),
          )
        )
      ),
      home: HomePage()
    );
  }
}
