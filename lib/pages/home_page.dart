import 'package:flutter/material.dart';

import '../models/game.dart';
import '../services/api_service.dart';
import '../widgets/game_tile.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Game>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchGames();
  }

  void _reload() => setState(() => _future = ApiService.fetchGames());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browse Games')),
      body: FutureBuilder<List<Game>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
                    const SizedBox(height: 12),
                    Text('${snap.error}', textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    FilledButton(
                        onPressed: _reload, child: const Text('Coba lagi')),
                  ],
                ),
              ),
            );
          }
          final games = snap.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 6),
            itemCount: games.length,
            itemBuilder: (context, i) {
              final g = games[i];
              return GameTile(
                game: g,
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => DetailPage(gameId: g.id)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
