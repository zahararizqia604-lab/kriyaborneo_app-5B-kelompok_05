class Produk {
  final String id;
  final String nama;
  final String kategori;
  final int harga;
  final int stok;
  final String gambar;
  final String deskripsi;

  Produk({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.stok,
    required this.gambar,
    required this.deskripsi,
  });
}

// Fungsi bantu untuk mengubah angka menjadi format Rupiah (contoh: Rp 275.000)
String formatRupiah(int nominal) {
  final String str = nominal.toString();
  final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  final String hasil = str.replaceAllMapped(reg, (Match m) => '${m[1]}.');
  return 'Rp $hasil';
}

// Daftar 6 produk riil Kriya Borneo
final List<Produk> daftarProduk = [
  Produk(
    id: 'KB01',
    nama: 'Kain Sasirangan Pewarna Alam',
    kategori: 'Kain & Fashion',
    harga: 275000,
    stok: 10,
    gambar: 'assets/images/sasirangan_alam.png',
    deskripsi: 'Kain katun satin motif tradisional Kalimantan Selatan dengan pewarna alami kulit kayu ulin dan indigo. Panjang 2 meter.',
  ),
  Produk(
    id: 'KB02',
    nama: 'Tas Purun Kombinasi Sasirangan',
    kategori: 'Tas & Anyaman',
    harga: 135000,
    stok: 15,
    gambar: 'assets/images/tas_purun.png',
    deskripsi: 'Tas jinjing anyaman tumbuhan purun rawa khas Hulu Sungai dengan aksen saku kain sasirangan dan pegangan kulit.',
  ),
  Produk(
    id: 'KB03',
    nama: 'Syal Sasirangan Sutera Halus',
    kategori: 'Kain & Fashion',
    harga: 95000,
    stok: 20,
    gambar: 'assets/images/syal_sasirangan.png',
    deskripsi: 'Selendang syal sasirangan khas Banjarmasin bernuansa hijau zamrud dan emas, ringan dan nyaman dipakai sehari-hari.',
  ),
  Produk(
    id: 'KB04',
    nama: 'Kopiah Jangang Khas Margasari',
    kategori: 'Aksesoris',
    harga: 165000,
    stok: 8,
    gambar: 'assets/images/kopiah_jangang.png',
    deskripsi: 'Peci tradisional khas Margasari, Tapin yang dianyam rapi secara manual dari serat akar tumbuhan jangang alami.',
  ),
  Produk(
    id: 'KB05',
    nama: 'Bros Batu Kecubung Martapura',
    kategori: 'Aksesoris',
    harga: 185000,
    stok: 12,
    gambar: 'assets/images/bros_martapura.png',
    deskripsi: 'Bros ukiran perak khas pengrajin Martapura berhiaskan permata batu kecubung ungu asli Kalimantan Selatan.',
  ),
  Produk(
    id: 'KB06',
    nama: 'Dompet Clutch Purun Etnik',
    kategori: 'Tas & Anyaman',
    harga: 75000,
    stok: 18,
    gambar: 'assets/images/dompet_purun.png',
    deskripsi: 'Dompet tangan anyaman purun berpadu list kain sasirangan dan kancing kayu, cocok untuk suvenir.',
  ),
];
