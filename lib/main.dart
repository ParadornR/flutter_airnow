import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_airnow/app/UI/loading/loading_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      home: LoadingPage(),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final baseTheme = ThemeData(brightness: brightness, useMaterial3: true);

    return baseTheme.copyWith(
      primaryColor: const Color(0xFF3B78B3),
      scaffoldBackgroundColor: Colors.white,
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
        surface: const Color(0xFFD7FBF4),
      ),
      textTheme: GoogleFonts.promptTextTheme(),
    );
  }
}
