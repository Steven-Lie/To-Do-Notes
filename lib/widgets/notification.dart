import 'package:flutter/material.dart';

void showNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.orange.shade900,
      content: Text(
        message.toString(),
      ),
    ),
  );
}
