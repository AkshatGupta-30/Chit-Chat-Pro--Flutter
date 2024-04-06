import 'package:chit_chat_pro/src/pages/home_page.dart';
import 'package:chit_chat_pro/utils/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chit Chat Pro',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: HomePage()
    );
  }
}
