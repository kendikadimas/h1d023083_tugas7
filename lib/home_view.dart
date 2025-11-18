import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _username = '';
  int _openCount = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('username') ?? 'Guest';
    final count = (prefs.getInt('home_count') ?? 0) + 1;
    await prefs.setInt('home_count', count);
    setState(() {
      _username = name;
      _openCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      drawer: SimpleDrawer(username: _username),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Halo $_username!', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Halaman ini telah dibuka $_openCount kali.'),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _QuickCard(title: 'Info Aplikasi', icon: Icons.info_outline, onTap: () => Navigator.pushNamed(context, '/info')),
                _QuickCard(title: 'Profil', icon: Icons.person_outline, onTap: () => Navigator.pushNamed(context, '/profile')),
                _QuickCard(title: 'Keluar', icon: Icons.logout, color: Colors.redAccent, onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  const _QuickCard({required this.title, required this.icon, required this.onTap, this.color});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color ?? Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 26),
            const SizedBox(height: 12),
            Text(title),
          ],
        ),
      ),
    );
  }
}
