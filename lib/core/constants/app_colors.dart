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

  // ==================== TODO: Additional Colors ====================
  // Will be added progressively in future tutorials:

  // TODO P5-6: Add priority colors
  // static const Color priorityHigh = Color(0xFFDC2626);
  // static const Color priorityMedium = Color(0xFFF59E0B);
  // static const Color priorityLow = Color(0xFF10B981);

  // TODO P6-7: Add category colors
  // static const Color categoryStudy = Color(0xFF3B82F6);
  // static const Color categoryAssignment = Color(0xFF8B5CF6);
  // static const Color categoryExam = Color(0xFFEC4899);
  // static const Color categoryProject = Color(0xFF14B8A6);

  // TODO P7: Add status colors
  // static const Color statusCompleted = Color(0xFF059669);
  // static const Color statusPending = Color(0xFF6B7280);
  // static const Color statusOverdue = Color(0xFFEF4444);

  // TODO P13: Add chart colors
  // TODO P14: Add dark theme variants
}
