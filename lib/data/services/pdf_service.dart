import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PdfService {
  Future<File> createPdf(List<File> images) async {
    final pdf = pw.Document();

    for (final img in images) {
      final bytes = await img.readAsBytes();
      final image = pw.MemoryImage(bytes);
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Center(
            child: pw.Image(image, fit: pw.BoxFit.contain),
          ),
        ),
      );
    }

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/scanned_${DateTime.now().millisecondsSinceEpoch}.pdf');

    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<File> createPdfFromText(String text, {String? title}) async {
    final pdf = pw.Document();
    final safeText = text.trim();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          if (title != null && title.trim().isNotEmpty)
            pw.Text(
              title.trim(),
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          if (title != null && title.trim().isNotEmpty) pw.SizedBox(height: 12),
          pw.Text(
            safeText.isEmpty ? 'No content provided.' : safeText,
            style: const pw.TextStyle(fontSize: 12),
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File(
      '${dir.path}/text_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );

    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
