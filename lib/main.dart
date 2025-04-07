import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/home_main.dart';
import 'package:flutter_airnow/app/ui/profile/myprofile_page.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      home: HomeMain(),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: false, // ปิด M3 ถ้าไม่อยากให้โดน colorScheme ควบคุม
    );

    return baseTheme.copyWith(
      primaryColor: const Color(0xFF3B78B3),
      scaffoldBackgroundColor: const Color(0xFFD7FBF4),
      cardColor: const Color(0xFFA3E4FA),
      dividerColor: const Color(0xFFD1F8EF),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF3B78B3),
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: Color(0xFF3B78B3),
        elevation: 0,
      ),

      colorScheme: baseTheme.colorScheme.copyWith(
        primary: const Color(0xFF3B78B3),
        secondary: const Color(0xFF578FCC),
        background: const Color(0xFFD7FBF4),
      ),

      textTheme: GoogleFonts.promptTextTheme(baseTheme.textTheme),
    );
  }
}
