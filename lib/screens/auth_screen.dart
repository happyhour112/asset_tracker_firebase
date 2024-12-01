import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:asset_tracker/screens/home_screen.dart';
import 'package:asset_tracker/screens/login_or_register_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LoginOrRegisterScreen();
          }
        },
      ),
    );
  }
}
