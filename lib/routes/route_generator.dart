import 'package:flutter/material.dart';
import '../features/auth/screens/splash_screen.dart';
import 'app_routes.dart';

/// Route generator untuk handle navigation
///
/// CATATAN: Akan diperluas di pertemuan selanjutnya
class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      // Routes lain akan ditambahkan di sini sesuai kebutuhan

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
