import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileCard1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Gunakan data pengguna yang diperoleh
          Map<String, dynamic> userData = snapshot.data as Map<String, dynamic>;

          return Card(
            color: Color(0xff278EA5),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(userData['profile']), // Ganti dengan path gambar profil
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['username'] ?? 'Username',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        userData['email'] ?? 'user@example.com',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<Map<String, dynamic>> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userEmail = user.email ?? '';

      try {
        // Query Firestore berdasarkan alamat email
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Jika data ditemukan, kembalikan data pengguna
          return querySnapshot.docs.first.data() as Map<String, dynamic>;
        } else {
          // Jika data tidak ditemukan, kembalikan map kosong
          return {};
        }
      } catch (e) {
        print('Error: $e');
        // Kembalikan map kosong jika terjadi kesalahan
        return {};
      }
    } else {
      // Kembalikan map kosong jika pengguna tidak login
      return {};
    }
  }
}