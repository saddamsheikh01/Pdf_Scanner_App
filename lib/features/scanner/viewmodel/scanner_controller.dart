import 'dart:io';
import 'package:flutter/material.dart';
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
