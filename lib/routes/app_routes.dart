/// Route name constants untuk navigation
///
/// CATATAN: Hanya routes untuk P4-5 (splash, task list)
/// Routes untuk auth, detail, dll akan ditambahkan di pertemuan selanjutnya
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String taskList = '/tasks';

  // Routes lain akan ditambahkan sesuai kebutuhan:
  // - '/login' di Pertemuan 9 (Authentication)
  // - '/task-detail' di Pertemuan 5 (Task Detail)
  // - '/add-task' di Pertemuan 6 (Form)
  // - dst...
}
