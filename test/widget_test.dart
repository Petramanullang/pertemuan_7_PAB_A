import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pertemuan_7/main.dart';

void main() {
  testWidgets('Tambah transaksi memperbarui total', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: DashboardPage()));

    // Data awal
    expect(find.text('Total: Rp 75000'), findsOneWidget);
    expect(find.text('Makan Siang'), findsOneWidget);

    // Buka form
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Isi form
    await tester.enterText(find.byType(TextFormField).at(0), 'Kopi');
    await tester.enterText(find.byType(TextFormField).at(1), '10000');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Total dan daftar ikut berubah
    expect(find.text('Total: Rp 85000'), findsOneWidget);
    expect(find.text('Kopi'), findsOneWidget);
  });
}
