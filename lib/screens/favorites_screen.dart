// lib/screens/favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/project.dart';
import 'dart:convert'; 

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Project> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteList = prefs.getStringList('favoriteProjects');
    if (favoriteList != null) {
      setState(() {
        _favorites = favoriteList
            .map((item) => Project.fromJson(jsonDecode(item)))
            .toList();
      });
    }
  }

  Future<void> _removeFavorite(Project project) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites.remove(project); // Remove o projeto dos favoritos
    });

    // Atualiza a lista de favoritos no SharedPreferences
    final List<String> favoriteList =
        _favorites.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('favoriteProjects', favoriteList);
    
    // Retorna a lista atualizada para a tela inicial
    Navigator.pop(context, _favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
      ),
      body: _favorites.isEmpty
          ? const Center(child: Text('Nenhum projeto favorito ainda.'))
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final project = _favorites[index];
                return ListTile(
                  title: Text(project.ementa),
                  subtitle: Text('Ano: ${project.ano}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.star, color: Colors.yellow),
                    onPressed: () => _removeFavorite(project),
                  ),
                );
              },
            ),
    );
  }
}
