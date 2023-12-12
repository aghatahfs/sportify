import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _authService = FirebaseAuth.instance;

  Future<User?> signUpWithEmailandPassword(
    String email, pass, BuildContext context ) async {
      try {
        UserCredential credential = await _authService.createUserWithEmailAndPassword(email: email, password: pass);
        return credential.user;
      } catch (e) {
        final String errorMsg = e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.red,
          )
        );
      }
      return null;
    }

  Future<User?> loginWithEmailandPassword(
    String email, pass, BuildContext context ) async {
      try {
        UserCredential credential = await _authService.signInWithEmailAndPassword(email: email, password: pass);
        return credential.user;
      } catch (e) {
        final String errorMsg = e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.red,
          )
        );
      }
      return null;
    }
}