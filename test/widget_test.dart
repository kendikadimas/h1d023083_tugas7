// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:h1d023083_tugas7/main.dart';

void main() {
  testWidgets('Halaman login tampil awal', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MyApp());
    expect(find.text('Masuk Aplikasi'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
  testWidgets('Navigasi ke profil setelah login', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MyApp());
    // Isi form login
    await tester.enterText(find.byType(TextField).at(0), 'tester');
    await tester.enterText(find.byType(TextField).at(1), 'secret');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    // Pastikan halaman Home tampil
    expect(find.textContaining('Halo tester'), findsOneWidget);
    // Drawer icon is automatically inserted by Scaffold with AppBar -> find by tooltip or icon
    final Finder menuButton = find.byTooltip('Open navigation menu');
    expect(menuButton, findsOneWidget);
    await tester.tap(menuButton);
    await tester.pumpAndSettle();
    // Tap menu Profil di dalam Drawer (hindari bentrok dengan card di Home)
    final drawer = find.byType(Drawer);
    final profilTile = find.descendant(of: drawer, matching: find.widgetWithText(ListTile, 'Profil'));
    expect(profilTile, findsOneWidget);
    await tester.tap(profilTile);
    await tester.pumpAndSettle();
    expect(find.text('Profil Pengguna'), findsOneWidget);
    expect(find.text('Simpan'), findsOneWidget);
  });
}
