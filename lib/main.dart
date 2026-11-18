import 'package:flutter/material.dart';

void main() {
  runApp(const KasirApp());
}

class KasirApp extends StatelessWidget {
  const KasirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const KasirPage(),
    );
  }
}

class KasirPage extends StatefulWidget {
  const KasirPage({super.key});

  @override
  State<KasirPage> createState() => _KasirPageState();
}

class _KasirPageState extends State<KasirPage> {
  final harga1Controller = TextEditingController();
  final harga2Controller = TextEditingController();
  final diskonController = TextEditingController();

  int total = 0;
  int subtotal = 0;
  int potongan = 0;

  void hitungTotal() {
    // Mengambil angka dari setiap TextField.
    int harga1 = int.tryParse(harga1Controller.text) ?? 0;
    int harga2 = int.tryParse(harga2Controller.text) ?? 0;
    double diskon = double.tryParse(diskonController.text) ?? 0;

    // Membatasi diskon agar tidak kurang dari 0% atau lebih dari 100%.
    diskon = diskon.clamp(0, 100);

    setState(() {
      subtotal = harga1 + harga2;
      potongan = (subtotal * diskon / 100).round();
      total = subtotal - potongan;
    });
  }

  @override
  void dispose() {
    harga1Controller.dispose();
    harga2Controller.dispose();
    diskonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir Sederhana'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'Masukkan Harga Barang',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: harga1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Harga Barang 1',
                hintText: 'Contoh: 50000',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: harga2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Harga Barang 2',
                hintText: 'Contoh: 30000',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: diskonController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Diskon (%)',
                hintText: 'Contoh: 10',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: hitungTotal,
                child: const Text('Hitung Total'),
              ),
            ),
            const SizedBox(height: 25),

            const Text(
              'Hasil Perhitungan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Subtotal: Rp$subtotal'),
            Text('Potongan Diskon: Rp$potongan'),
            const Divider(),
            Text(
              'Total Harga: Rp$total',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
