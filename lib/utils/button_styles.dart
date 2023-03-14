import 'package:flutter/material.dart';

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  minimumSize: const Size(160, 50),
);

final ButtonStyle datePickerButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    maximumSize: const Size(160, 50),
    elevation: 0,
    side: const BorderSide(width: 1, color: Colors.grey));

final ButtonStyle filledButtonLargeStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  minimumSize: const Size.fromHeight(50),
);

final ButtonStyle outlinedButtonCompanyStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black54,
    backgroundColor: Colors.white,
    minimumSize: const Size.fromHeight(50),
    shape: const StadiumBorder() // NEW
    );
