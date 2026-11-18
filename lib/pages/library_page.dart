import 'package:flutter/material.dart';

import '../services/library_service.dart';
import '../widgets/game_tile.dart';
import 'detail_page.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library Anda')),
      body: ValueListenableBuilder(
        valueListenable: LibraryService.listenable(),
        builder: (context, box, _) {
          final games = LibraryService.getAll();
          if (games.isEmpty) {
            return const Center(
              child: Text('Library masih kosong.',
                  style: TextStyle(color: Colors.grey)),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 6),
            itemCount: games.length,
            itemBuilder: (context, i) {
              final g = games[i];
              return GameTile(
                game: g,
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () async {
                    await LibraryService.remove(g.id);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${g.title} dihapus dari library')));
                  },
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => DetailPage(gameId: g.id)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
