import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final ingredients = recipe['ingredientLines'] ?? ['Bahan tidak tersedia'];
    final totalTime = recipe['totalTime'] ?? 0;
    final calories = recipe['calories'] ?? 0.0;
    final source = recipe['source'] ?? 'Sumber tidak diketahui';
    final sourceUrl = recipe['url'];
    return Scaffold(
      appBar: AppBar(title: Text(recipe['label'] ?? 'Detail Resep')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                recipe['image'] ?? '',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              recipe['label'] ?? 'Nama Resep',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Waktu: $totalTime menit"),
            Text("Kalori: ${calories.toStringAsFixed(0)} kcal"),
            Text("Sumber: $source"),
            const SizedBox(height: 16),

            const Text(
              "Bahan-Bahan:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            ...ingredients.map<Widget>((item) => Text("• $item")).toList(),

            const SizedBox(height: 20),
            const Text(
              "Langkah Memasak (Umum):",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "1. Siapkan semua bahan terlebih dahulu.\n"
              "2. Ikuti urutan resep sesuai bahan.\n"
              "3. Masak sesuai jenis makanan.\n"
              "4. Sajikan selagi hangat.",
            ),

            const SizedBox(height: 20),

            if (sourceUrl != null)
              ElevatedButton.icon(
                onPressed: () async {
                  final Uri uri = Uri.parse(sourceUrl);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Gagal membuka tautan")),
                    );
                  }
                },
                icon: const Icon(Icons.link),
                label: const Text("Lihat Resep Asli"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 248, 142, 43),
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
