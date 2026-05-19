import 'package:flutter/material.dart';

Color characterScreenCardStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'alive':
      return const Color(0xff1d8f39);
    case 'dead':
      return const Color(0xffc83b32);
    default:
      return const Color(0xff68645c);
  }
}
