import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/utils/permissions.dart';
import '../../../data/services/camera_service.dart';
import '../../../data/services/pdf_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/services/text_recognition_service.dart';

class ScannerController extends ChangeNotifier {
  final CameraService _cameraService = CameraService();
  final PdfService _pdfService = PdfService();
  final StorageService _storageService = StorageService();
  final TextRecognitionService _textService = TextRecognitionService();

  final List<File> images = [];
  File? lastSavedPdf;
  String extractedText = '';

  Future<PageTapResult> handlePageTap(File image, int index) async {
    var textCopied = false;
    var pdfSaved = false;
    var text = '';
    File? savedFile;

    try {
      text = await _textService.extractTextFromImage(image);
      if (text.trim().isNotEmpty) {
        await Clipboard.setData(ClipboardData(text: text));
        textCopied = true;
      }
    } catch (error, stack) {
      debugPrint('Page text extraction failed: $error');
      debugPrintStack(stackTrace: stack);
    }

    final hasPermission = await PermissionUtils.requestStorage();
    if (!hasPermission) {
      debugPrint('Storage permission denied; continuing with app documents dir.');
    }

    try {
      final pdf = await _pdfService.createPdf([image]);
      final fileName =
          'scan_page_${index + 1}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final saved = await _storageService.saveToDownloads(
        pdf,
        fileName: fileName,
      );
      final exists = await saved.exists();
      if (exists) {
        pdfSaved = true;
        savedFile = saved;
        lastSavedPdf = saved;
        notifyListeners();
        await _storageService.openFile(saved);
      }
    } catch (error, stack) {
      debugPrint('Single-page PDF failed: $error');
      debugPrintStack(stackTrace: stack);
    }

    return PageTapResult(
      textCopied: textCopied,
      pdfSaved: pdfSaved,
      text: text,
      pdfFile: savedFile,
    );
  }

  Future<void> scanImage() async {
    final image = await _cameraService.captureImage();
    if (image != null) {
      images.add(image);
      debugPrint('Image added: ${image.path}');
      notifyListeners();
    } else {
      debugPrint('No image captured');
    }
  }

  Future<bool> generatePdf() async {
    if (images.isEmpty) {
      debugPrint('No images to create PDF');
      return false;
    }

    final hasPermission = await PermissionUtils.requestStorage();
    if (!hasPermission) {
      debugPrint('Storage permission denied; continuing with app documents dir.');
    }

    try {
      final pdf = await _pdfService.createPdf(images);
      final exists = await pdf.exists();
      debugPrint('PDF saved (app dir): ${pdf.path} (exists: $exists)');

      final saved = await _storageService.saveToDownloads(pdf);
      final savedExists = await saved.exists();
      debugPrint('PDF saved (Downloads): ${saved.path} (exists: $savedExists)');

      if (savedExists) {
        lastSavedPdf = saved;
        notifyListeners();
        await _storageService.openFile(saved);
      }
      return savedExists;
    } catch (error, stack) {
      debugPrint('PDF generation failed: $error');
      debugPrintStack(stackTrace: stack);
      return false;
    }
  }

  Future<bool> shareLastPdf() async {
    final file = lastSavedPdf;
    if (file == null) {
      debugPrint('No PDF to share');
      return false;
    }
    final exists = await file.exists();
    if (!exists) {
      debugPrint('Saved PDF no longer exists: ${file.path}');
      return false;
    }
    await Share.shareXFiles([XFile(file.path)], text: 'Scanned PDF');
    return true;
  }

  Future<bool> extractText() async {
    if (images.isEmpty) {
      debugPrint('No images to extract text');
      return false;
    }
    try {
      extractedText = '';
      notifyListeners();
      final text = await _textService.extractTextFromImages(images);
      extractedText = text;
      notifyListeners();
      debugPrint('Extracted text length: ${extractedText.length}');
      return extractedText.isNotEmpty;
    } catch (error, stack) {
      debugPrint('Text extraction failed: $error');
      debugPrintStack(stackTrace: stack);
      return false;
    }
  }

  void clear() {
    images.clear();
    lastSavedPdf = null;
    extractedText = '';
    notifyListeners();
  }
}

class PageTapResult {
  final bool textCopied;
  final bool pdfSaved;
  final String text;
  final File? pdfFile;

  const PageTapResult({
    required this.textCopied,
    required this.pdfSaved,
    required this.text,
    required this.pdfFile,
  });
}
