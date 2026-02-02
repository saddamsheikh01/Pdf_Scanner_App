import 'package:flutter/material.dart';
import '../features/scanner/view/scanner_screen.dart';
import '../features/splash/view/splash_screen.dart';
import '../features/text_pdf/view/text_pdf_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const scanner = '/scanner';
  static const textPdf = '/text-pdf';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    scanner: (_) => const ScannerScreen(),
    textPdf: (_) => const TextPdfScreen(),
  };
}
