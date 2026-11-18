import 'package:flutter/material.dart';

import '../models/produk_model.dart';

class HalamanKeranjang extends StatefulWidget {
  final Map<String, int> keranjang;

  const HalamanKeranjang({super.key, required this.keranjang});

  @override
  State<HalamanKeranjang> createState() => _HalamanKeranjangState();
}

class _HalamanKeranjangState extends State<HalamanKeranjang> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tunaiController = TextEditingController();
  String _metodeBayar = 'Tunai';

  final List<String> _opsiPembayaran = ['Tunai', 'QRIS', 'Transfer Bank'];

  @override
  void dispose() {
    _namaController.dispose();
    _tunaiController.dispose();
    super.dispose();
  }

  List<Produk> get _itemDiKeranjang {
    return daftarProduk
        .where((p) => (widget.keranjang[p.id] ?? 0) > 0)
        .toList();
  }

  int get _totalBelanja {
    int total = 0;
    for (final produk in _itemDiKeranjang) {
      final qty = widget.keranjang[produk.id] ?? 0;
      total += produk.harga * qty;
    }
    return total;
  }

  void _ubahJumlah(Produk produk, int perubahan) {
    final qtySekarang = widget.keranjang[produk.id] ?? 0;
    final qtyBaru = qtySekarang + perubahan;

    if (qtyBaru <= 0) {
      setState(() {
        widget.keranjang.remove(produk.id);
      });
    } else if (qtyBaru > produk.stok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Stok ${produk.nama} maksimal ${produk.stok} pcs'),
          backgroundColor: Colors.red.shade700,
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      setState(() {
        widget.keranjang[produk.id] = qtyBaru;
      });
    }
  }

  void _prosesCheckout() {
    final items = _itemDiKeranjang;
    if (items.isEmpty) return;

    final total = _totalBelanja;
    int uangTunai = 0;
    int kembalian = 0;

    if (_metodeBayar == 'Tunai') {
      final angkaBersih = _tunaiController.text.replaceAll(
        RegExp(r'[^0-9]'),
        '',
      );
      uangTunai = int.tryParse(angkaBersih) ?? 0;

      if (uangTunai < total) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Nominal uang tunai kurang dari total belanja!',
            ),
            backgroundColor: Colors.red.shade700,
          ),
        );
        return;
      }
      kembalian = uangTunai - total;
    }

    final namaPelanggan = _namaController.text.trim().isEmpty
        ? 'Pelanggan Umum'
        : _namaController.text.trim();

    final kodeTransaksi =
        'KB-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    final ringkasanItem = items.map((p) {
      final qty = widget.keranjang[p.id] ?? 0;
      return {
        'nama': p.nama,
        'qty': qty,
        'harga': p.harga,
        'subtotal': p.harga * qty,
      };
    }).toList();

    setState(() {
      widget.keranjang.clear();
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Column(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF064E3B), size: 52),
              SizedBox(height: 8),
              Text(
                'Pembayaran Berhasil',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                'KRIYA BORNEO - BANJARMASIN',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Text(
                  'No. Nota : $kodeTransaksi',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  'Pelanggan: $namaPelanggan',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  'Metode   : $_metodeBayar',
                  style: const TextStyle(fontSize: 12),
                ),
                const Divider(),
                ...ringkasanItem.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${item['nama']} (${item['qty']}x)',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                          formatRupiah(item['subtotal'] as int),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Bayar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatRupiah(total),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF064E3B),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                if (_metodeBayar == 'Tunai') ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Uang Tunai', style: TextStyle(fontSize: 12)),
                      Text(
                        formatRupiah(uangTunai),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kembalian',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formatRupiah(kembalian),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB45309),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF064E3B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Selesai & Kembali ke Katalog'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _itemDiKeranjang;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Keranjang & Checkout'),
        backgroundColor: const Color(0xFF064E3B),
        foregroundColor: Colors.white,
      ),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 72,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Keranjang belanja masih kosong',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF064E3B),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Pilih Produk Dulu'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Daftar Produk di Keranjang
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final produk = items[index];
                      final qty = widget.keranjang[produk.id] ?? 0;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  produk.gambar,
                                  width: 64,
                                  height: 64,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 64,
                                    height: 64,
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.image),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      produk.nama,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      formatRupiah(produk.harga),
                                      style: const TextStyle(
                                        color: Color(0xFFB45309),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => _ubahJumlah(produk, -1),
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                    color: Colors.red.shade700,
                                  ),
                                  Text(
                                    '$qty',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => _ubahJumlah(produk, 1),
                                    icon: const Icon(Icons.add_circle_outline),
                                    color: const Color(0xFF064E3B),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Panel Pembayaran / Checkout
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _namaController,
                        decoration: InputDecoration(
                          labelText: 'Nama Pelanggan (Opsional)',
                          hintText: 'Contoh: Ibu Siti',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Pembayaran:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _metodeBayar,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              items: _opsiPembayaran.map((metode) {
                                return DropdownMenuItem(
                                  value: metode,
                                  child: Text(metode),
                                );
                              }).toList(),
                              onChanged: (nilai) {
                                if (nilai != null) {
                                  setState(() {
                                    _metodeBayar = nilai;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      if (_metodeBayar == 'Tunai') ...[
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _tunaiController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Uang Diterima (Rp)',
                                  hintText: 'Contoh: 300000',
                                  prefixIcon: const Icon(
                                    Icons.payments_outlined,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  isDense: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: () {
                                _tunaiController.text = _totalBelanja
                                    .toString();
                              },
                              child: const Text('Uang Pas'),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Belanja',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            formatRupiah(_totalBelanja),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF064E3B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _prosesCheckout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF064E3B),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.receipt_long),
                          label: const Text(
                            'Proses Pembayaran',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
