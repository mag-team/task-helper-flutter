import 'dart:math';

import 'package:flutter/material.dart';

extension ColorUtil on Color {
  static Color genRandomColor(int seed, [Color mix = const Color(0xffaaaaaa)]) {
    final rand = Random(seed);
    final red = rand.nextInt(256);
    final green = rand.nextInt(256);
    final blue = rand.nextInt(256);

    return Color.fromARGB(
      255,
      (mix.red + red) ~/ 2,
      (mix.green + green) ~/ 2,
      (mix.blue + blue) ~/ 2,
    );
  }
}
