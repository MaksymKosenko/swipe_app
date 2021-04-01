import 'package:flutter/material.dart';

  BoxDecoration GradientBack() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff0B3138), Color(0xff0A4A46)],
      ),
    );
  }

  BoxDecoration GradientInputBack() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0x3327AE63), Color(0x3327AE9E)],
      ),
    );
  }