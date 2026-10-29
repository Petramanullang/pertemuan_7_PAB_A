import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: DashboardPage()));
}

// Menampilkan total dan daftar pengeluaran
class Expense {
  // Constructor
  Expense(this.title, this.amount);
  final String title;
  final double amount;

  // Nilainya tidak bisa ditetapkan ulang setelah diinisialisasi
}

// Mengolah setiap transaksi
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() {
    return _DashboardPageState();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  double _total = 75000; // total awal
  final _expenses = [
    Expense('Makan Siang', 25000),
    Expense('Transport', 50000),
  ]; // menyimpan dua transaksi awal
  Future<void> _openForm() async {
    // membuka halaman formulir transaksi
    final result = await Navigator.push<Expense>(
      context,
      MaterialPageRoute(
        builder: (_) {
          return const AddTransactionPage();
        },
      ),
    );

    // menghentikan proses, jika tidak ada transaksi
    if (result == null) return;

    // ketika ada transaksi baru, transaksi akan ditambahkan
    // Flutter akan membangun ulang
    setState(() {
      _expenses.add(result);
      _total += result.amount;
    });
  }

  // Menampilkan tampilan dashboard berdasarkan state saat ini
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Kerangka
      appBar: AppBar(title: Text('Total: Rp ${_total.toStringAsFixed(0)}')),
      body: ListView(
        children: [
          for (final e in _expenses)
            ListTile(
              title: Text(e.title),
              trailing: Text('Rp ${e.amount.toStringAsFixed(0)}'),
            ),
        ],
      ),

      // membuat tombol tambah dengan ikon +
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Form untuk memasukkan transaksi baru
class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});
  @override
  State<AddTransactionPage> createState() {
    return _AddTransactionPageState();
  }
}

// mengelola input pengguna dan proses validasi
class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _tileController = TextEditingController();
  final _amountController = TextEditingController();

  // Proses menyimpan transaksi
  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final amount = double.parse(_amountController.text.trim());

    // menutup halaman formulir dan mengirim objek Expense ke dashboard
    Navigator.pop(context, Expense(_tileController.text.trim(), amount));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Transaksi')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _tileController,
              decoration: const InputDecoration(labelText: 'Judul transaksi'),
              validator: (v) {
                return v == null || v.trim().isEmpty
                    ? 'judul wajib diisi'
                    : null;
              },
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nominal'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'nominal wajib diisi';
                final n = double.tryParse((v.trim()));
                if (n == null || n <= 0) return 'nominal harus angka > 0';
                return null;
              },
            ),

            // Kembali ke Dashboard - Data ditambahkan dan total diperbarui
            ElevatedButton(onPressed: _submit, child: const Text('Simpan')),
          ],
        ),
      ),
    );
  }
}
