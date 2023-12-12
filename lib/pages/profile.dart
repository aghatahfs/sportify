import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sportifyv5/pages/login.dart';
import 'package:sportifyv5/widget/profilecard1.dart';
import 'package:sportifyv5/widget/profilecard2.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xff1F4287),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileCard1(),
            SizedBox(height: 16),
            ProfileCard2(),
            SizedBox(height: 16),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();

        // Navigasi ke halaman login setelah berhasil logout
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false,
        );
      },
      child: Text('Logout'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
    );
  }
}
