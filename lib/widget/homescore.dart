import 'package:flutter/material.dart';
import 'package:sportifyv5/widget/Category.dart';

class ItemKategori extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView(
          scrollDirection: Axis.horizontal, // Set arah scroll menjadi horizontal
          children: [
            CategoryItem(icon: Icons.sports_soccer, text: 'Sepak Bola'),
            CategoryItem(icon: Icons.sports_basketball, text: 'Basket'),
            CategoryItem(icon: Icons.sports_tennis, text: 'Badminton'),
            CategoryItem(icon: Icons.sports_volleyball, text: 'Voli'),
          ],
        ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const CategoryItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman Artikel dengan mengirimkan data kategori
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtikelCategory(dkategori: text),
          ),
        );
      },
      child: Container(
        width: 120,
        padding: EdgeInsets.all(4),
        child: Card(
          color: Color(0xff071E3D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  text,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
