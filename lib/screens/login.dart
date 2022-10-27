import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_notes/widgets/notification.dart';
import 'package:to_do_notes/widgets/password_text_form_field.dart';
import 'package:to_do_notes/widgets/email_text_form_field.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/logo.png',
                  height: 100,
                  width: 100,
                  color: const Color(0xFF0058CA),
                ),
                const SizedBox(
                  height: 48,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmailTextFormField(usernameController: _emailController),
                      const SizedBox(
                        height: 24,
                      ),
                      PasswordTextFormField(
                          passwordController: _passwordController),
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  if (FirebaseAuth.instance.currentUser ==
                                      null) {
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text);
                                    } on FirebaseAuthException catch (e) {
                                      showNotification(
                                          context, e.message.toString());
                                    }
                                  } else {
                                    await FirebaseAuth.instance.signOut();
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0006A9),
                                minimumSize: const Size.fromHeight(40),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                    color: Color(0xFF0006A9),
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Don't have account?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF0006A9),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                    color: Color(0xFF0006A9),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            OutlinedButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/register'),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  width: 2,
                                  color: Color(0xFF0006A9),
                                ),
                                minimumSize: const Size.fromHeight(40),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF0006A9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
