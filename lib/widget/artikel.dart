// artikel.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportifyv5/model/artikeldata.dart';
import 'package:sportifyv5/pages/detailartikel.dart'; // Import the new file

class Artikel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artikel'),
        backgroundColor: Color(0xff071E3D),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('artikel').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;
          List<Item> items = documents
              .map((doc) => Item(
                    judul: doc['judul'],
                    gambar: doc['gambar'],
                    isi: doc['isi'],
                    kategori: doc['kategori'],
                  ))
              .toList();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailArtikel(item: items[index]),
                    ),
                  );
                },
                child: Card(
                  color: Color(0xff278EA5),
                  elevation: 5,
                  margin: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15.0)),
                        child: Image.asset(
                          items[index].gambar,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[index].judul,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              items[index].kategori,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 211, 210, 210),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
