/// Model untuk item pada daftar game (endpoint /api/games).
class Game {
  final int id;
  final String title;
  final String thumbnail;
  final String genre;
  final String platform;

  const Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.genre,
    required this.platform,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json['id'] as int,
        title: (json['title'] ?? '') as String,
        thumbnail: (json['thumbnail'] ?? '') as String,
        genre: (json['genre'] ?? '') as String,
        platform: (json['platform'] ?? '') as String,
      );

  /// Dipakai untuk menyimpan ke Hive.
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'thumbnail': thumbnail,
        'genre': genre,
        'platform': platform,
      };

  factory Game.fromMap(Map<dynamic, dynamic> map) => Game(
        id: map['id'] as int,
        title: map['title'] as String,
        thumbnail: map['thumbnail'] as String,
        genre: map['genre'] as String,
        platform: map['platform'] as String,
      );
}

/// Model untuk detail game (endpoint /api/game?id=).
class GameDetail {
  final int id;
  final String title;
  final String thumbnail;
  final String genre;
  final String platform;
  final String releaseDate;
  final String publisher;
  final String developer;
  final String description;
  final List<String> screenshots;

  const GameDetail({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.genre,
    required this.platform,
    required this.releaseDate,
    required this.publisher,
    required this.developer,
    required this.description,
    required this.screenshots,
  });

  factory GameDetail.fromJson(Map<String, dynamic> json) {
    final shots = (json['screenshots'] as List<dynamic>? ?? [])
        .map((e) => (e as Map<String, dynamic>)['image'] as String)
        .toList();
    return GameDetail(
      id: json['id'] as int,
      title: (json['title'] ?? '') as String,
      thumbnail: (json['thumbnail'] ?? '') as String,
      genre: (json['genre'] ?? '') as String,
      platform: (json['platform'] ?? '') as String,
      releaseDate: (json['release_date'] ?? '-') as String,
      publisher: (json['publisher'] ?? '-') as String,
      developer: (json['developer'] ?? '-') as String,
      description: (json['description'] ?? '') as String,
      screenshots: shots,
    );
  }

  Game toGame() => Game(
        id: id,
        title: title,
        thumbnail: thumbnail,
        genre: genre,
        platform: platform,
      );
}
