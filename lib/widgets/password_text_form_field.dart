import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_notes/providers/password_visibility_provider.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    Key? key,
    required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final passwordVisibilityProvider =
        Provider.of<PasswordVisibilityProvider>(context, listen: false);

    return Consumer<PasswordVisibilityProvider>(
      builder: (context, value, child) => TextFormField(
        validator: (value) {
          if (value?.trim() == '') {
            return "Don't Empty";
          } else if (value!.length < 6) {
            return 'Min length is 6';
          } else {
            return null;
          }
        },
        controller: _passwordController,
        cursorColor: const Color(0xFF0006A9),
        decoration: InputDecoration(
          labelText: 'Password',
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
          suffixIcon: IconButton(
            onPressed: () {
              passwordVisibilityProvider.changeObscureStatus();
            },
            icon: passwordVisibilityProvider.isObscure
                ? const Icon(
                    Icons.visibility_off,
                    color: Color(0xFF0006A9),
                  )
                : const Icon(
                    Icons.visibility,
                    color: Color(0xFF0006A9),
                  ),
          ),
        ),
        obscureText: passwordVisibilityProvider.isObscure,
      ),
    );
  }
}
