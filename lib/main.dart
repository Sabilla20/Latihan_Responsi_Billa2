import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'pages/main_page.dart';
import 'services/auth_service.dart';
import 'services/library_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LibraryService.init();
  final loggedIn = await AuthService.isLoggedIn();
  runApp(HydraGamesApp(loggedIn: loggedIn));
}

class HydraGamesApp extends StatelessWidget {
  final bool loggedIn;
  const HydraGamesApp({super.key, required this.loggedIn});

  static const Color primary = Color(0xFF2F8CFF);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hydra Games',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(primary: primary),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: primary,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: loggedIn ? const MainPage() : const LoginPage(),
    );
  }
}
