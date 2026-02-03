import 'package:flutter/material.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 1800));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.scanner);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    isDark ? const Color(0xFF0F1115) : const Color(0xFFF5F7FB),
                    isDark ? const Color(0xFF1A1C22) : const Color(0xFFE2EAF8),
                    isDark ? const Color(0xFF12141A) : const Color(0xFFF7FAFF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: isDark ? 0.12 : 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: scheme.secondary.withValues(alpha: isDark ? 0.16 : 0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GlassContainer(
                    borderRadius: 28,
                    padding: const EdgeInsets.all(22),
                    color: Colors.white.withValues(alpha: isDark ? 0.12 : 0.65),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: isDark ? 0.18 : 0.4),
                    ),
                    child: SizedBox(
                      width: 76,
                      height: 76,
                      child: Image.asset(
                        'assets/scanner.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'PDF Scanner',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 26,
                          color: scheme.primary,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Scan - Enhance - Share',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurface.withValues(alpha: 0.7),
                        ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        minHeight: 6,
                        color: scheme.primary,
                        backgroundColor: scheme.primary.withValues(
                          alpha: isDark ? 0.25 : 0.12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
