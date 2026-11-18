import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/game.dart';

/// Semua proses fetch & parse API dipisahkan di file ini.
class ApiService {
  static const String _baseUrl = 'https://www.freetogame.com/api';

  /// Daftar semua game.
  static Future<List<Game>> fetchGames() async {
    final res = await http
        .get(Uri.parse('$_baseUrl/games'))
        .timeout(const Duration(seconds: 30));
    if (res.statusCode != 200) {
      throw Exception('Gagal memuat daftar game (${res.statusCode})');
    }
    final list = jsonDecode(res.body) as List<dynamic>;
    return list.map((e) => Game.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Detail satu game berdasarkan id.
  static Future<GameDetail> fetchGameDetail(int id) async {
    final res = await http
        .get(Uri.parse('$_baseUrl/game?id=$id'))
        .timeout(const Duration(seconds: 30));
    if (res.statusCode != 200) {
      throw Exception('Gagal memuat detail game (${res.statusCode})');
    }
    return GameDetail.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }
}
