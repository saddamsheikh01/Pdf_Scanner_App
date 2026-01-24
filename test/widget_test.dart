import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_scanner_app/main.dart';

void main() {
  testWidgets('App launches without crashing', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const PdfScannerApp());

    // Verify Scanner screen title exists
    expect(find.text('PDF Scanner'), findsOneWidget);
  });
}
