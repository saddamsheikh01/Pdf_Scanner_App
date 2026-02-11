import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../routes/app_routes.dart';
import '../viewmodel/scanner_controller.dart';
import '../widgets/image_preview.dart';
import '../widgets/guide_tile.dart';
import '../widgets/step_chip.dart';
class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScannerController(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF0F1115)
                            : const Color(0xFFF5F7FB),
                        Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF1A1C22)
                            : const Color(0xFFE7EEFB),
                        Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF12141A)
                            : const Color(0xFFF7FAFF),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -60,
                right: -30,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8A6D1A).withValues(
                      alpha: Theme.of(context).brightness == Brightness.dark
                          ? 0.14
                          : 0.08,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: 140,
                left: -40,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB08A2E).withValues(
                      alpha: Theme.of(context).brightness == Brightness.dark
                          ? 0.18
                          : 0.1,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Consumer<ScannerController>(
                builder: (context, controller, _) {
                  final hasImages = controller.images.isNotEmpty;
                  final scheme = Theme.of(context).colorScheme;
                  final textTheme = Theme.of(context).textTheme;
                  final isDark =
                      Theme.of(context).brightness == Brightness.dark;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PDF Scanner',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleLarge?.copyWith(
                                      color: scheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Capture, enhance, and export',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: scheme.onSurface.withValues(alpha: 0.6),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Step 1: Scan | Step 2: Review | Step 3: Export',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.labelMedium?.copyWith(
                                      color: scheme.onSurface.withValues(alpha: 0.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.textPdf,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  child: GlassContainer(
                                    borderRadius: 20,
                                    blur: 16,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    color:
                                        Colors.white.withValues(alpha: isDark ? 0.1 : 0.7),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: isDark ? 0.18 : 0.5),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.text_fields,
                                          size: 16,
                                          color: scheme.primary,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Text PDF',
                                          style: textTheme.labelMedium?.copyWith(
                                            color: scheme.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GlassContainer(
                                  borderRadius: 20,
                                  blur: 16,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  color:
                                      Colors.white.withValues(alpha: isDark ? 0.1 : 0.7),
                                  border: Border.all(
                                    color:
                                        Colors.white.withValues(alpha: isDark ? 0.18 : 0.5),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.auto_awesome,
                                        size: 16,
                                        color: scheme.primary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Auto enhance',
                                        style: textTheme.labelMedium?.copyWith(
                                          color: scheme.primary,
                                          fontWeight: FontWeight.w600,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                scheme.primary,
                                scheme.primary.withValues(alpha: 0.82),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: scheme.primary.withValues(alpha: 0.2),
                                blurRadius: 16,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                    'assets/scanner.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Smart Scan',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      hasImages
                                          ? '${controller.images.length} page(s) ready'
                                          : 'Add pages to build your PDF',
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.8),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      hasImages
                                          ? 'Tap a page to copy text or save as PDF'
                                          : 'Place the document flat, then scan',
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.75),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  hasImages
                                      ? '${controller.images.length} pages'
                                      : 'Ready',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 2, 16, 6),
                        child: GlassContainer(
                          borderRadius: 16,
                          blur: 16,
                          padding: const EdgeInsets.all(14),
                          color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.72),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: isDark ? 0.18 : 0.45),
                          ),
                          child: Row(
                            children: const [
                              Expanded(
                                child: GuideTile(
                                  icon: Icons.center_focus_strong,
                                  title: 'Scan',
                                  subtitle: 'Capture pages',
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GuideTile(
                                  icon: Icons.view_carousel,
                                  title: 'Review',
                                  subtitle: 'Check clarity',
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GuideTile(
                                  icon: Icons.picture_as_pdf,
                                  title: 'Export',
                                  subtitle: 'Save or share',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: hasImages
                                ? Column(
                                    key: const ValueKey('list'),
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              'Captured pages',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${controller.images.length} total',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withValues(alpha: 0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: controller.images.length,
                                          itemBuilder: (context, index) {
                                            final file = controller.images[index];
                                            return ImagePreview(
                                              file: file,
                                              index: index,
                                              onTap: () async {
                                                final result = await controller
                                                    .handlePageTap(file, index);
                                                if (!context.mounted) return;
                                                final messages = <String>[];
                                                messages.add(
                                                  result.textCopied
                                                      ? 'Text copied'
                                                      : 'No text found',
                                                );
                                                messages.add(
                                                  result.pdfSaved
                                                      ? 'Page PDF saved'
                                                      : 'Page PDF failed',
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      messages.join(' - '),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(
                                    key: const ValueKey('empty'),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GlassContainer(
                                          borderRadius: 26,
                                          blur: 20,
                                          padding: const EdgeInsets.all(18),
                                          color: Colors.white.withValues(
                                            alpha: isDark ? 0.12 : 0.65,
                                          ),
                                          border: Border.all(
                                            color: Colors.white.withValues(
                                              alpha: isDark ? 0.18 : 0.4,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.crop_free,
                                            size: 38,
                                            color: Color(0xFF111827),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'No pages yet',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Tap Scan below to capture a document',
                                          style: TextStyle(
                                            color: Colors.black.withValues(alpha: 0.6),
                                          ),
                                        ),
                                        const SizedBox(height: 18),
                                        Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          alignment: WrapAlignment.center,
                                          children: [
                                            StepChip(
                                              icon: Icons.camera_alt,
                                              label: 'Scan',
                                            ),
                                            StepChip(
                                              icon: Icons.view_agenda,
                                              label: 'Review',
                                            ),
                                            StepChip(
                                              icon: Icons.picture_as_pdf,
                                              label: 'Export',
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 14),
                                        GlassContainer(
                                          borderRadius: 20,
                                          blur: 16,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 8,
                                          ),
                                          color:
                                              Colors.white.withValues(alpha: isDark ? 0.1 : 0.7),
                                          border: Border.all(
                                            color: Colors.white.withValues(
                                              alpha: isDark ? 0.18 : 0.5,
                                            ),
                                          ),
                                          child: Text(
                                            'Tip: Keep the document flat and well lit',
                                            style: TextStyle(
                                              color: Colors.black.withValues(alpha: 0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      if (controller.extractedText.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: GlassContainer(
                            borderRadius: 16,
                            blur: 16,
                            padding: const EdgeInsets.all(16),
                            color: Colors.white.withValues(alpha: isDark ? 0.12 : 0.75),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Extracted Text',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      tooltip: 'Copy',
                                      onPressed: () async {
                                        await Clipboard.setData(
                                          ClipboardData(
                                            text: controller.extractedText,
                                          ),
                                        );
                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Text copied'),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.copy),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  controller.extractedText,
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(22),
                        ),
                        child: GlassContainer(
                          borderRadius: 22,
                          blur: 20,
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                          color: Colors.white.withValues(alpha: isDark ? 0.14 : 0.85),
                          border: Border(
                            top: BorderSide(
                              color: Colors.white.withValues(alpha: isDark ? 0.22 : 0.55),
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 18,
                              offset: const Offset(0, -4),
                            ),
                          ],
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: controller.scanImage,
                                  icon: const Icon(Icons.camera_alt),
                                  label: const Text('Scan'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: scheme.primary,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: hasImages
                                      ? () async {
                                          final ok =
                                              await controller.generatePdf();
                                          if (!context.mounted) return;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                ok
                                                    ? 'PDF created'
                                                    : 'PDF creation failed',
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                  icon: const Icon(Icons.picture_as_pdf),
                                  label: const Text('Create PDF'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: scheme.primary,
                                    side: BorderSide(
                                      color: hasImages
                                          ? scheme.primary
                                          : scheme.primary.withValues(alpha: 0.2),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                decoration: BoxDecoration(
                                  color: scheme.primary.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  tooltip: 'Extract text',
                                  onPressed: hasImages
                                      ? () async {
                                          final ok =
                                              await controller.extractText();
                                          if (!context.mounted) return;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                ok
                                                    ? 'Text extracted'
                                                    : 'No text found',
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                  icon: const Icon(Icons.text_snippet),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: scheme.primary.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  tooltip: 'Share',
                                  onPressed: controller.lastSavedPdf != null
                                      ? () async {
                                          final ok =
                                              await controller.shareLastPdf();
                                          if (!context.mounted) return;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                ok
                                                    ? 'Share sheet opened'
                                                    : 'No PDF to share',
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                  icon: const Icon(Icons.share),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: scheme.primary.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  tooltip: 'Clear',
                                  onPressed: hasImages ? controller.clear : null,
                                  icon: const Icon(Icons.delete_outline),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



