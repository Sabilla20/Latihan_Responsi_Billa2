import 'package:flutter/material.dart';

import '../models/game.dart';

/// Item list game: thumbnail, nama, genre, platform.
/// Dipakai di Home dan Library (trailing berbeda).
class GameTile extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;
  final Widget trailing;

  const GameTile({
    super.key,
    required this.game,
    required this.onTap,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1A1A),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 84,
          child: Row(
            children: [
              SizedBox(
                width: 112,
                height: 84,
                child: Image.network(
                  game.thumbnail,
                  fit: BoxFit.cover,
                  loadingBuilder: (c, child, p) => p == null
                      ? child
                      : const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                  errorBuilder: (c, e, s) => const ColoredBox(
                    color: Color(0xFF2A2A2A),
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        game.genre,
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      game.platform,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              trailing,
              const SizedBox(width: 6),
            ],
          ),
        ),
      ),
    );
  }
}
