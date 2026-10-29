// Contoh kode pada Langkah 4 modul: kerangka TabBar dengan isi sementara.
// Jalankan dengan: flutter run -t contoh_langkah/langkah4_tabbar.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const DompetkuApp());
}

class DompetkuApp extends StatelessWidget {
  const DompetkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dompetku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const DashboardPage(),
    );
  }
}

// ---------------------------------------------------------------------
// HALAMAN UTAMA (berisi TabBar)
// ---------------------------------------------------------------------
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // DefaultTabController menghubungkan TabBar dengan TabBarView
    return DefaultTabController(
      length: 3, // jumlah tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dompetku'),
          // TabBar diletakkan di bagian bawah AppBar
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.receipt_long), text: 'Transaksi'),
              Tab(icon: Icon(Icons.category), text: 'Kategori'),
              Tab(icon: Icon(Icons.person), text: 'Profil'),
            ],
          ),
        ),
        // Isi setiap tab, urutannya harus sama dengan urutan Tab di atas
        body: const TabBarView(
          children: [
            Center(child: Text('Halaman Transaksi')),
            Center(child: Text('Halaman Kategori')),
            Center(child: Text('Halaman Profil')),
          ],
        ),
      ),
    );
  }
}
