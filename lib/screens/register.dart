import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_notes/widgets/notification.dart';
import 'package:to_do_notes/widgets/password_text_form_field.dart';
import 'package:to_do_notes/widgets/email_text_form_field.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 64, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'REGISTER',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF0006A9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Form(
                  key: _formKey,
                  child: Column(
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
                        child: ElevatedButton(
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_formKey.currentState!.validate()) {
                              if (FirebaseAuth.instance.currentUser == null) {
                                final navigator = Navigator.of(context);
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text);

                                  navigator.pushNamedAndRemoveUntil(
                                      '/home', (route) => false);
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
                            'Register',
                            style: TextStyle(fontSize: 14),
                          ),
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
