# Tugas 7 — H1D023083

### Fitur utama:

- Routing bernama sederhana: `/login`, `/home`, `/info`, `/profile`
- Login menyimpan `username` ke `SharedPreferences`
- Drawer untuk navigasi & logout
- Counter berapa kali halaman Home dibuka (`home_count`)
- Tombol bersihkan storage di halaman Info

### Screenshot

![Login](docs/screenshots/01_login.png)
![Home](docs/screenshots/02_home.png)
![Drawer](docs/screenshots/03_drawer.png)
![Profile](docs/screenshots/04_profile.png)
![Info](docs/screenshots/05_info.png)

## Struktur Kode

- `lib/main.dart` : Root `MaterialApp` + definisi routes.
- `lib/login_view.dart` : Form login, simpan username.
- `lib/home_view.dart` : Tampilkan username & counter kunjungan, quick cards.
- `lib/info_view.dart` : Ringkasan data tersimpan + tombol bersihkan storage.
- `lib/drawer_widget.dart` : Drawer navigasi & logout.
- `lib/profile_view.dart` : Edit dan simpan nama pengguna ke local storage.

## Penjelasan Kode Utama

### Routing

Menggunakan map `routes` di `main.dart`:

```dart
MaterialApp(
  initialRoute: '/login',
  routes: {
    '/login': (c) => const LoginView(),
    '/home': (c) => const HomeView(),
    '/info': (c) => const InfoView(),
    '/profile': (c) => const ProfileView(),
  },
);
```

### SharedPreferences 


```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString('username', u);
final count = (prefs.getInt('home_count') ?? 0) + 1;
await prefs.setInt('home_count', count);
```

### Drawer Navigasi & Profil

`SimpleDrawer` memuat info username + navigasi (termasuk Profil). Halaman profil memungkinkan update nama yang tersimpan.

### Profil

Halaman profil mengambil username lalu mengizinkan pengeditan:

```dart
final prefs = await SharedPreferences.getInstance();
_nameCtrl.text = prefs.getString('username') ?? '';
await prefs.setString('username', newName);
```


```dart
ListTile(
  leading: const Icon(Icons.home_rounded),
  title: const Text('Beranda'),
  onTap: () => Navigator.pushReplacementNamed(context, '/home'),
);
```

### Login Flow

Validasi minimal (username tidak kosong & password >= 4). Username disimpan lalu berpindah ke `/home`.

```dart
if (u.isEmpty || p.length < 4) { setState(() => _error = 'Username kosong...'); return; }
await prefs.setString('username', u);
Navigator.pushReplacementNamed(context, '/home');
```

