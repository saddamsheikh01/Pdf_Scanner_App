import 'package:flutter/material.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/utils/permissions.dart';
import '../../../data/services/pdf_service.dart';
import '../../../data/services/storage_service.dart';

class TextPdfScreen extends StatefulWidget {
  const TextPdfScreen({super.key});

  @override
  State<TextPdfScreen> createState() => _TextPdfScreenState();
}

class _TextPdfScreenState extends State<TextPdfScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final PdfService _pdfService = PdfService();
  final StorageService _storageService = StorageService();
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _createPdf() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    final hasPermission = await PermissionUtils.requestStorage();
    if (!hasPermission) {
      debugPrint('Storage permission denied; continuing with app documents dir.');
    }

    try {
      final pdf = await _pdfService.createPdfFromText(
        _contentController.text,
        title: _titleController.text,
      );
      final fileName =
          'text_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final saved = await _storageService.saveToDownloads(
        pdf,
        fileName: fileName,
      );
      final exists = await saved.exists();
      if (!mounted) return;
      if (exists) {
        await _storageService.openFile(saved);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF saved to Downloads')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF save failed')),
        );
      }
    } catch (error, stack) {
      debugPrint('Text PDF failed: $error');
      debugPrintStack(stackTrace: stack);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF creation failed')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      isDark ? const Color(0xFF0F1115) : const Color(0xFFF5F7FB),
                      isDark ? const Color(0xFF1A1C22) : const Color(0xFFE7EEFB),
                      isDark ? const Color(0xFF12141A) : const Color(0xFFF7FAFF),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: GlassContainer(
                    borderRadius: 18,
                    blur: 16,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.72),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Text to PDF',
                          style: textTheme.titleLarge?.copyWith(
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              scheme.primary,
                              scheme.primary.withValues(alpha: 0.85),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: scheme.primary.withValues(alpha: 0.25),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.16),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.note_alt,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Create a clean PDF',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Add a title, paste your text, and export to Downloads.',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.85),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      GlassContainer(
                        borderRadius: 18,
                        blur: 16,
                        padding: const EdgeInsets.all(16),
                        color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title (optional)',
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Helps you find the file later.',
                              style: textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _titleController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Document title',
                                prefixIcon: const Icon(Icons.title),
                                filled: true,
                                fillColor: Colors.white.withValues(
                                  alpha: isDark ? 0.08 : 0.8,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color: scheme.primary.withValues(alpha: 0.2),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color: scheme.primary.withValues(alpha: 0.15),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Content',
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Use clear paragraphs for best readability.',
                              style: textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _contentController,
                              maxLines: 10,
                              decoration: InputDecoration(
                                hintText: 'Paste or type your text here...',
                                prefixIcon: const Icon(Icons.subject),
                                filled: true,
                                fillColor: Colors.white.withValues(
                                  alpha: isDark ? 0.08 : 0.8,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color: scheme.primary.withValues(alpha: 0.2),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color: scheme.primary.withValues(alpha: 0.15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _isSaving ? null : _createPdf,
                        icon: _isSaving
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.picture_as_pdf),
                        label: Text(
                          _isSaving ? 'Creating...' : 'Create PDF',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: scheme.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
