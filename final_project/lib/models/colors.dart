import 'package:flutter/material.dart';

const Color PrimaryColor = Color(0xFF3D2464);
const Color SecondaryColor = Color(0xFF4D307F);
const Color TertiaryColor = Color(0xFF2C1745);
const Color LightColor = Color(0xFF6541A5);

const LinearGradient GradientBackground = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.4, 0.4, 0.2, 0.7, 0.1],
  colors: [
    Color(0xFF6541A5),
    Color(0xFF4D307F),
    Color(0xFF472B75),
    Color(0xFF3D2464),
    Color(0xFF2C1745),
  ],
);
