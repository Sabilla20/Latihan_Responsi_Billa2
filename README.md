# Hydra Games - Responsi Praktikum Pemrograman Aplikasi Mobile

Aplikasi Flutter untuk browsing dan "mendapatkan" game dari FreeToGame API.

## Cara menjalankan

Folder `android/` dan `ios/` tidak disertakan. Generate dulu dengan:

```bash
flutter create . --project-name hydra_games --platforms android,ios
flutter pub get
flutter run
```

**Android**: pastikan izin internet ada di `android/app/src/main/AndroidManifest.xml`
(biasanya sudah ada untuk debug, tapi tambahkan untuk release):

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## Struktur

```
lib/
  main.dart                    # entry point, tema, init Hive
  models/game.dart             # Game & GameDetail
  services/
    api_service.dart           # fetch & parse API (terpisah)
    auth_service.dart          # SharedPreferences (login)
    library_service.dart       # Hive (library)
  pages/
    login_page.dart
    main_page.dart             # BottomNavigationBar
    home_page.dart
    detail_page.dart
    library_page.dart
    profile_page.dart
  widgets/game_tile.dart
```

## Fitur sesuai kriteria

- Login (email & password bebas) disimpan di SharedPreferences, sesi tetap tersimpan
- Home: BottomNavigationBar (Home/Library/Profile), ListView game (thumbnail, nama, genre, platform), loading indicator
- Detail: hero image, genre & platform, nama, rilis/publisher/developer, screenshots, deskripsi, tombol Get / In Library (UI berbeda), tombol kembali, loading indicator
- Library: list game dengan tombol delete, klik membuka Detail, data disimpan dengan Hive
- Profile: email (SharedPreferences), jumlah game (Hive), tombol logout ke Login
- Bonus: model class

## Pengumpulan

Push ke repo publik GitHub bernama `[NIM]_Responsi_Mobile`.
