import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';

/// Simple splash screen untuk Pertemuan 4
///
/// CATATAN: Splash logic (auto-navigate, check auth) akan ditambahkan
/// di Pertemuan 9 (Authentication & Session Management)
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon (placeholder - akan diganti dengan real icon nanti)
            Icon(
              Icons.school_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 24),

            // App Name
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),

            const SizedBox(height: 8),

            // App Tagline
            Text(
              AppStrings.appTagline,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(),
                  ),
            ),

            const SizedBox(height: 48),

            // Loading Indicator
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
