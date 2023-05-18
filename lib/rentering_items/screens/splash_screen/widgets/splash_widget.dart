import 'package:flutter/material.dart';

Center logo() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 150, left: 10),
      child: Image.asset('assets/images/Logo.png'),
    ),
  );
}
