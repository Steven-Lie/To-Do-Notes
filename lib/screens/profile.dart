import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF0058CA),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            StreamBuilder(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) => Text(
                '${snapshot.data?.email}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 36,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF3D3D),
                  minimumSize: const Size.fromHeight(40),
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
