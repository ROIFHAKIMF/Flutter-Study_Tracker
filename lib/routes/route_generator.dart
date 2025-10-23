import 'package:flutter/material.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/tasks/models/task_model.dart';
import '../features/tasks/screens/add_task_screen.dart';
import '../features/tasks/screens/task_detail_screen.dart';
import '../features/tasks/screens/task_list_screen.dart';
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

      case AppRoutes.taskList:
        return MaterialPageRoute(
          builder: (_) => const TaskListScreen(),
        );

      case AppRoutes.addTask: // NEW: tambahkan case ini
        return MaterialPageRoute(
          builder: (_) => const AddTaskScreen(),
        );

      case AppRoutes.taskDetail:
        final task = settings.arguments as TaskModel;
        return MaterialPageRoute(
          builder: (_) => TaskDetailScreen(task: task),
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
