import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Score extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Minggu ini'),
        backgroundColor: Color(0xff071E3D),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('score').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            var documents = snapshot.data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var document = documents[index];
                return Liga(
                  tim1: document['tim1'],
                  tim2: document['tim2'],
                  logo1: document['logo1'],
                  logo2: document['logo2'],
                  score: document['score'],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Liga extends StatelessWidget {
  final String tim1;
  final String tim2;
  final String logo1;
  final String logo2;
  final String score;

  Liga({
    required this.tim1,
    required this.tim2,
    required this.logo1,
    required this.logo2,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
        child: Card(
          color: Color(0xff278EA5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(logo1, height: 80, width: 80),
                    Text(
                      tim1,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      score,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.network(logo2, height: 80, width: 80),
                    Text(
                      tim2,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
