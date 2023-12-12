// detailartikel.dart

import 'package:flutter/material.dart';
import 'package:sportifyv5/model/artikeldata.dart';

class DetailArtikel extends StatelessWidget {
  final Item item;

  DetailArtikel({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.judul),
        backgroundColor: Color (0xff071E3D),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              item.gambar,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              item.judul,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              item.kategori,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              item.isi,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
