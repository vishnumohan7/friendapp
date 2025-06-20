import 'package:flutter/material.dart';

class AppTextStyles {
  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Color(0xff111827),
  );

  // Link
  static const TextStyle link = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Color(0xff2563EB),
  );

  // Body
  static const TextStyle body = TextStyle(fontSize: 16, color: Colors.black87);

  static const TextStyle bodyLight = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  // Labels
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

  // Buttons
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Caption
  static const TextStyle caption = TextStyle(fontSize: 12, color: Colors.grey);
}
