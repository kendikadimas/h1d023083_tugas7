import 'package:flutter/material.dart';

class SimpleDrawer extends StatelessWidget {
  final String username;
  const SimpleDrawer({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(radius: 26, child: Text(username.isEmpty ? '?' : username[0].toUpperCase())),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const Text('Pengguna aktif'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home_rounded),
              title: const Text('Beranda'),
              onTap: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline_rounded),
              title: const Text('Profil'),
              onTap: () => Navigator.pushReplacementNamed(context, '/profile'),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('Info'),
              onTap: () => Navigator.pushReplacementNamed(context, '/info'),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Keluar', style: TextStyle(color: Colors.redAccent)),
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false),
            ),
          ],
        ),
      ),
    );
  }
}
