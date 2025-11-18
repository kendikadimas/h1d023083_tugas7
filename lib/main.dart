import 'package:flutter/material.dart';
import 'login_view.dart';
import 'home_view.dart';
import 'info_view.dart';
import 'profile_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 7 Sederhana',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/home': (context) => const HomeView(),
        '/info': (context) => const InfoView(),
        '/profile': (context) => const ProfileView(),
      },
    );
  }
}

