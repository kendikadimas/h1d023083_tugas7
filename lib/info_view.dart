import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer_widget.dart';

class InfoView extends StatefulWidget {
  const InfoView({super.key});
  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  String _username = '';
  int _homeCount = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Guest';
      _homeCount = prefs.getInt('home_count') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Aplikasi')),
      drawer: SimpleDrawer(username: _username),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: $_username'),
            Text('Kunjungan Beranda: $_homeCount'),
            const SizedBox(height: 16),
            const Text('Fitur:'),
            const Text('• Login & simpan username'),
            const Text('• Drawer navigasi'),
            const Text('• Penyimpanan lokal dengan SharedPreferences'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Storage dibersihkan')));
                _load();
              },
              child: const Text('Bersihkan Storage'),
            ),
          ],
        ),
      ),
    );
  }
}
