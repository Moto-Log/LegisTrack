import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:legistrack/screens/login/login.dart';
import 'package:legistrack/screens/projects_screen.dart'; // Atualizando para usar ProjectsScreen diretamente
import 'package:legistrack/screens/favorites_screen.dart'; // Adicionando tela de favoritos
import 'package:legistrack/screens/profile_screen.dart'; // Adicionando tela de perfil

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoggedInStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Center(child: CircularProgressIndicator()),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'LegisTrack',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: snapshot.data == true ? const ProjectsScreen() : const LoginPage(),
            routes: {
              '/favorites': (context) => const FavoritesScreen(),
              '/profile': (context) => const ProfileScreen(),
            },
          );
        }
      },
    );
  }

  Future<bool> _checkLoggedInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
