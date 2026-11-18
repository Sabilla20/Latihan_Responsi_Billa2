import 'package:flutter/material.dart';

import '../main.dart';
import '../models/game.dart';
import '../services/api_service.dart';
import '../services/library_service.dart';

class DetailPage extends StatefulWidget {
  final int gameId;
  const DetailPage({super.key, required this.gameId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<GameDetail> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchGameDetail(widget.gameId);
  }

  void _reload() =>
      setState(() => _future = ApiService.fetchGameDetail(widget.gameId));

  Future<void> _toggle(GameDetail d, bool owned) async {
    final messenger = ScaffoldMessenger.of(context);
    if (owned) {
      await LibraryService.remove(d.id);
      messenger.showSnackBar(
          SnackBar(content: Text('${d.title} dihapus dari library')));
    } else {
      await LibraryService.add(d.toGame());
      messenger.showSnackBar(
          SnackBar(content: Text('${d.title} ditambahkan ke library')));
    }
  }

  Widget _chip(String text, {bool filled = false}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: filled ? const Color(0xFF333333) : null,
          border: Border.all(color: Colors.grey.shade600),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(text, style: const TextStyle(fontSize: 11)),
      );

  Widget _meta(String label, String value) => Padding(
        padding: const EdgeInsets.only(right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 12)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<GameDetail>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError || !snap.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.grey),
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
          final d = snap.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero image
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    d.thumbnail,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => const ColoredBox(
                      color: Color(0xFF2A2A2A),
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        _chip(d.genre),
                        const SizedBox(width: 8),
                        _chip(d.platform),
                      ]),
                      const SizedBox(height: 10),
                      Text(d.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(children: [
                        _meta('Release Date', d.releaseDate),
                        _meta('Publisher', d.publisher),
                        _meta('Developer', d.developer),
                      ]),
                      const SizedBox(height: 16),
                      // Tombol Get / In Library (UI berbeda)
                      ValueListenableBuilder(
                        valueListenable: LibraryService.listenable(),
                        builder: (context, box, _) {
                          final owned = LibraryService.contains(d.id);
                          return SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: owned
                                ? FilledButton.icon(
                                    onPressed: () => _toggle(d, owned),
                                    icon: const Icon(Icons.check, size: 18),
                                    label: const Text('In Library'),
                                    style: FilledButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xFF555555),
                                      foregroundColor: Colors.white,
                                    ),
                                  )
                                : FilledButton.icon(
                                    onPressed: () => _toggle(d, owned),
                                    icon: const Icon(Icons.add, size: 18),
                                    label: const Text('Get'),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: HydraGamesApp.primary,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Screenshots',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      if (d.screenshots.isEmpty)
                        const Text('Tidak ada screenshot.',
                            style: TextStyle(color: Colors.grey))
                      else
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: d.screenshots.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                            itemBuilder: (_, i) => ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                d.screenshots[i],
                                width: 160,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => const SizedBox(
                                  width: 160,
                                  child: ColoredBox(
                                    color: Color(0xFF2A2A2A),
                                    child: Icon(Icons.broken_image,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      const Text('Overview',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(d.description,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white70, height: 1.4)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
