import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    Key? key,
    required TextEditingController usernameController,
  })  : _emailController = usernameController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => value?.trim() == '' ? "Don't Empty" : null,
      controller: _emailController,
      cursorColor: const Color(0xFF0006A9),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: const TextStyle(
          color: Color(0xFF0006A9),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF0006A9),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF0006A9),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
