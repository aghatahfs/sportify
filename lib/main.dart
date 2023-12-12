import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sportifyv5/firebase_options.dart';
import 'package:sportifyv5/pages/profile.dart';
import 'package:sportifyv5/pages/home.dart';
import 'package:sportifyv5/pages/score.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sportifyv5/widget/artikel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sportifyv5/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  Color c1 = const Color(0xff21E6BF);
  Color c2 = const Color(0xff278EA5);
  Color c3 = const Color(0xff1F4287);
  Color c4 = const Color(0xff071E3D);

  void goToPage(index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List _pages = [
    Home(),
    Artikel(),
    Score(),
    Profile(),
  ];

  Future<User?> checkUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<User?>(
        future: checkUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return Scaffold(
                body: _pages[currentIndex],
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff071E3D),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    child: GNav(
                      backgroundColor: c4,
                      color: c1,
                      activeColor: c4,
                      tabBackgroundColor: c1,
                      gap: 8,
                      padding: EdgeInsets.all(12),
                      selectedIndex: currentIndex,
                      onTabChange: (index) {
                        goToPage(index);
                      },
                      tabs: [
                        GButton(
                          icon: Icons.home,
                          text: 'home',
                        ),
                        GButton(
                          icon: Icons.explore,
                          text: ' Explore',
                        ),
                        GButton(
                          icon: Icons.pin,
                          text: 'Score',
                        ),
                        GButton(
                          icon: Icons.settings,
                          text: 'Profile',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Login();
            }
          }
        },
      ),
    );
  }
}
