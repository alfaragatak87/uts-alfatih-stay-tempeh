import 'package:flutter/material.dart';

void main() {
  runApp(const AlfatihHotelApp());
}

class AlfatihHotelApp extends StatelessWidget {
  const AlfatihHotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stay Tempeh',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const WelcomeScreen(), 
    );
  }
}

// ==========================================
// SCREEN 1: LAYAR WELCOME (SIMPEL & ELEGAN)
// ==========================================
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SYARAT: MENGGUNAKAN SCAFFOLD
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        // SYARAT: WIDGET DASAR (Column, Icon, Text, Button)
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.hotel_class, size: 100, color: Colors.white), 
            const SizedBox(height: 20),
            const Text( 
              'STAY TEMPEH',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Text(
              'Pusat Penginapan Lokal Tempeh',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 50),
            ElevatedButton( 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                // SYARAT: NAVIGASI (Pindah ke Screen 2)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GridHotelScreen()),
                );
              },
              child: const Text('LIHAT DAFTAR HOTEL', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// SCREEN 2: LAYAR KATALOG (GRID / KOTAK-KOTAK)
// ==========================================
class GridHotelScreen extends StatelessWidget {
  const GridHotelScreen({super.key});

  final List<Map<String, String>> hotels = const [
    {
      'nama': 'Pandanwangi Resort', 'lokasi': 'Desa Pandanwangi', 'harga': 'Rp 850k', 'rating': '4.8',
      'gambar': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500' 
    },
    {
      'nama': 'Gesang View Lodge', 'lokasi': 'Desa Gesang', 'harga': 'Rp 600k', 'rating': '4.5',
      'gambar': 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500' 
    },
    {
      'nama': 'Tempeh Tengah Inn', 'lokasi': 'Tempeh Tengah', 'harga': 'Rp 400k', 'rating': '4.2',
      'gambar': 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=500' 
    },
    {
      'nama': 'Kaliwungu Cabin', 'lokasi': 'Desa Kaliwungu', 'harga': 'Rp 550k', 'rating': '4.6',
      'gambar': 'https://images.unsplash.com/photo-1496417263034-38ec4f0b665a?w=500' 
    },
    {
      'nama': 'Jokarto Guest House', 'lokasi': 'Desa Jokarto, Tempeh', 'harga': 'Rp 350k', 'rating': '4.7',
      'gambar': 'https://images.unsplash.com/photo-1517840901100-8179e982acb7?w=500' 
    },
    {
      'nama': 'Besuk Heritage', 'lokasi': 'Desa Besuk, Tempeh', 'harga': 'Rp 750k', 'rating': '4.9',
      'gambar': 'https://images.unsplash.com/photo-1455587734955-081b22074882?w=500' 
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Penginapan'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // MENGGUNAKAN GRIDVIEW UNTUK KOTAK-KOTAK KECIL
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          crossAxisSpacing: 10, 
          mainAxisSpacing: 10, 
          childAspectRatio: 0.75, 
        ),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // SYARAT: NAVIGASI KE SCREEN 3
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailHotelScreen(data: hotels[index])),
              );
            },
            child: Card( 
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect( 
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      // Memanggil gambar dari internet dengan aman
                      child: Image.network(
                        hotels[index]['gambar']!,
                        width: double.infinity,
                        fit: BoxFit.cover, 
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hotels[index]['nama']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 12, color: Colors.grey),
                            // Expanded untuk mencegah teks lokasi terlalu panjang (overflow)
                            Expanded(child: Text(hotels[index]['lokasi']!, style: const TextStyle(color: Colors.grey, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(hotels[index]['harga']!, style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// SCREEN 3: LAYAR DETAIL HOTEL 
// ==========================================
class DetailHotelScreen extends StatelessWidget {
  final Map<String, String> data;

  const DetailHotelScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['nama']!),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Memanggil gambar yang sesuai dengan yang di-klik
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                data['gambar']!,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.broken_image, size: 80, color: Colors.grey)),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(data['nama']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    Text(' ${data['rating']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey),
                Text(' Lokasi: ${data['lokasi']}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            const Divider(height: 40),
            const Text('Fasilitas:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [Icon(Icons.wifi, color: Colors.indigo), Text('WiFi')]),
                Column(children: [Icon(Icons.pool, color: Colors.indigo), Text('Kolam')]),
                Column(children: [Icon(Icons.restaurant, color: Colors.indigo), Text('Resto')]),
              ],
            ),
            const Spacer(), 
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Anda berhasil memesan ${data['nama']}')),
                  );
                },
                child: Text('PESAN SEKARANG - ${data['harga']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}