import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognitionService {
  Future<String> extractTextFromImage(File image) async {
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    try {
      final input = InputImage.fromFilePath(image.path);
      final result = await recognizer.processImage(input);
      return result.text.trim();
    } finally {
      await recognizer.close();
    }
  }

  Future<String> extractTextFromImages(List<File> images) async {
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final buffer = StringBuffer();

    try {
      for (var i = 0; i < images.length; i += 1) {
        final image = images[i];
        final input = InputImage.fromFilePath(image.path);
        final result = await recognizer.processImage(input);
        if (result.text.trim().isEmpty) {
          continue;
        }
        if (buffer.isNotEmpty) {
          buffer.writeln('\n--- Page ${i + 1} ---\n');
        }
        buffer.writeln(result.text.trim());
      }
    } finally {
      await recognizer.close();
    }

    return buffer.toString();
  }
}
