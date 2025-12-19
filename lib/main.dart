import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animation Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// --- HALAMAN UTAMA ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variabel state untuk animasi interaktif
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Space Explorer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. HERO ANIMATION (Transisi Halaman)
            const Text("Ketuk roket untuk meluncur:", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigasi ke halaman detail
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailPage()));
              },
              child: const Hero(
                tag: 'rocket-hero', // Tag harus SAMA persis di kedua halaman
                child: Icon(
                  Icons.rocket_launch_rounded,
                  size: 80,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            
            const Divider(height: 60, thickness: 1, indent: 40, endIndent: 40),

            // 2. INTERACTIVE ANIMATION (AnimatedContainer)
            const Text("Animasi Interaktif (Ketuk kotak):", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: AnimatedContainer(
                // Durasi animasi
                duration: const Duration(milliseconds: 500),
                // Curve membuat gerakan terlihat lebih natural (tidak kaku)
                curve: Curves.easeInOutBack,
                
                // Properti yang akan dianimasikan
                width: _isExpanded ? 200 : 100,
                height: _isExpanded ? 100 : 100,
                decoration: BoxDecoration(
                  color: _isExpanded ? Colors.orange : Colors.blue,
                  borderRadius: BorderRadius.circular(_isExpanded ? 30 : 10),
                  boxShadow: [
                    if (_isExpanded)
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                  ],
                ),
                child: Center(
                  child: Text(
                    _isExpanded ? "WHOOSH!" : "Klik Saya",
                    style: const TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- HALAMAN DETAIL ---
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(title: const Text('Orbit Space')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tujuan Hero Animation
            const Hero(
              tag: 'rocket-hero', // Tag sama dengan halaman sebelumnya
              child: Icon(
                Icons.rocket_launch_rounded,
                size: 200, // Ukuran lebih besar
                color: Colors.deepPurple,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Selamat datang di Orbit!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Kembali ke Bumi"),
            ),
          ],
        ),
      ),
    );
  }
}