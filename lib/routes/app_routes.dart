import 'package:flutter/material.dart';
import '../features/scanner/view/scanner_screen.dart';

class AppRoutes {
  static const scanner = '/';

  static Map<String, WidgetBuilder> routes = {
    scanner: (_) => const ScannerScreen(),
  };
}
