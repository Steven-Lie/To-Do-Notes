import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_notes/screens/home.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> cekSession() async {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => StreamBuilder<User?>(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const Home();
                } else {
                  return Login();
                }
              },
            ),
          ),
          (route) => false,
        );
      },
    );
  }

  @override
  void initState() {
    cekSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFF0058CA),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png',
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'To Do Notes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
