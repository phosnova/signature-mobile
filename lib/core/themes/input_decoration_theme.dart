import 'package:flutter/material.dart';

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: Colors.grey[200],
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey)),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.deepPurple),
  ),
  labelStyle: TextStyle(color: Colors.grey[700]),
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
);
