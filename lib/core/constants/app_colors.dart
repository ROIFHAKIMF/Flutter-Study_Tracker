import 'package:flutter/material.dart';

/// App color constants using Material Design 3 color system
///
/// NOTE: Colors akan ditambahkan progressively seiring tutorial:
/// - P4-5: Base colors (primary, secondary, background, error)
/// - P5-6: Priority & category colors (saat implement task cards & forms)
/// - P7: Status colors (saat implement state management)
/// - P13: Chart colors (saat implement analytics dashboard)
/// - P14: Dark theme variants (saat implement theme toggle)
class AppColors {
  AppColors._(); // Prevent instantiation

  // ==================== Material Design 3 Base Colors ====================
  // Used for: App theme, basic UI components (P4-5)

  // Primary Colors
  static const Color primary = Color(0xFF6750A4);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimaryContainer = Color(0xFF21005D);

  // Secondary Colors
  static const Color secondary = Color(0xFF625B71);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE8DEF8);
  static const Color onSecondaryContainer = Color(0xFF1D192B);

  // Background & Surface
  static const Color background = Color(0xFFFFFBFE);
  static const Color onBackground = Color(0xFF1C1B1F);
  static const Color surface = Color(0xFFFFFBFE);
  static const Color onSurface = Color(0xFF1C1B1F);

  // Error
  static const Color error = Color(0xFFB3261E);
  static const Color onError = Color(0xFFFFFFFF);

  // Outline
  static const Color outline = Color(0xFF79747E);

  // NEW: Tambahkan Priority Colors
  // ==================== Priority Colors (P5) ====================

  /// High priority - Red (urgent, critical)
  static const Color priorityHigh = Color(0xFFDC2626);
  static const Color priorityHighLight = Color(0xFFFEE2E2);

  /// Medium priority - Orange (important, attention needed)
  static const Color priorityMedium = Color(0xFFF59E0B);
  static const Color priorityMediumLight = Color(0xFFFEF3C7);

  /// Low priority - Green (can wait, relaxed)
  static const Color priorityLow = Color(0xFF10B981);
  static const Color priorityLowLight = Color(0xFFD1FAE5);

  // NEW: Tambahkan Status Colors
  // ==================== Status Colors (P5) ====================

  /// Completed - Success green
  static const Color statusCompleted = Color(0xFF059669);
  static const Color statusCompletedLight = Color(0xFFD1FAE5);

  /// Pending - Neutral grey
  static const Color statusPending = Color(0xFF6B7280);
  static const Color statusPendingLight = Color(0xFFF3F4F6);

  /// Overdue - Warning red
  static const Color statusOverdue = Color(0xFFEF4444);
  static const Color statusOverdueLight = Color(0xFFFEE2E2);

// NEW: Tambahkan Surface Variant setelah outline (Material Design 3 standard)
  // ==================== Surface Variant (P6) ====================
  // Used for: Filled input backgrounds, subtle surfaces
  static const Color surfaceVariant = Color(0xFFE7E0EC);

  // ... existing priority & status colors tidak berubah ...

  // NEW: Tambahkan Category Colors setelah Status Colors section
  // ==================== Category Colors (P6) ====================
  // Used for: Category chips, visual categorization in task cards

  /// Study category - Blue (academic, learning)
  static const Color categoryStudy = Color(0xFF3B82F6);
  static const Color categoryStudyLight = Color(0xFFDBEAFE);

  /// Assignment category - Purple (tasks, homework)
  static const Color categoryAssignment = Color(0xFF8B5CF6);
  static const Color categoryAssignmentLight = Color(0xFFEDE9FE);

  /// Project category - Indigo (group work, major tasks)
  static const Color categoryProject = Color(0xFF6366F1);
  static const Color categoryProjectLight = Color(0xFFE0E7FF);

  /// Personal category - Pink (personal development, hobbies)
  static const Color categoryPersonal = Color(0xFFEC4899);
  static const Color categoryPersonalLight = Color(0xFFFCE7F3);

// CHANGED: Update TODO comments - hapus category yang sudah ditambahkan
// ==================== TODO: Chart Colors (P13) ====================
// ==================== TODO: Dark Theme Variants (P14) ====================
}
