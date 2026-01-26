import 'package:flutter/material.dart';
import '../features/scanner/view/scanner_screen.dart';
import '../features/text_pdf/view/text_pdf_screen.dart';

class AppRoutes {
  static const scanner = '/';
  static const textPdf = '/text-pdf';

  static Map<String, WidgetBuilder> routes = {
    scanner: (_) => const ScannerScreen(),
    textPdf: (_) => const TextPdfScreen(),
  };
}
