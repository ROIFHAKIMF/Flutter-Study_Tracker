import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import 'package:intl/intl.dart'; // NEW: untuk date formatting
import '../models/task_model.dart'; // NEW: untuk TaskCategory
// NEW: Import flutter_quill untuk rich text editing
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Form key untuk validation
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers
  final _titleController = TextEditingController();
  // NEW: QuillController untuk rich text
  late quill.QuillController _descriptionController;

  // Loading state
  bool _isLoading = false;

  // NEW: Track description validation error
  bool _showDescriptionError = false;

  // NEW: Tambahkan state untuk date, category, priority
  DateTime? _selectedDate;
  TaskCategory? _selectedCategory;
  TaskPriority _selectedPriority = TaskPriority.medium; // default medium

  @override
  void initState() {
    super.initState();
    // NEW: Initialize QuillController dengan empty document
    _descriptionController = quill.QuillController.basic();
  }

  @override
  void dispose() {
    // Clean up controllers saat widget disposed
    _titleController.dispose();
    _descriptionController.dispose(); // QuillController juga perlu dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addTask),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: AppStrings.taskTitle,
                  hintText: 'e.g., Complete Math Assignment',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: Validators.taskTitle,
                // Auto-validate after first error
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),

              const SizedBox(height: 16),

// REMOVED: TextFormField untuk description
              // NEW: Rich Text Editor dengan flutter_quill
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label
                  Text(
                    AppStrings.taskDescription,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Quill Toolbar (formatting options)
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                    child: quill.QuillSimpleToolbar(
                      configurations: quill.QuillSimpleToolbarConfigurations(
                        controller: _descriptionController,
                        toolbarSize: 36,
                        // Hide all other buttons
                        showStrikeThrough: false,
                        showInlineCode: false,
                        showColorButton: false,
                        showBackgroundColorButton: false,
                        showClearFormat: false,
                        showAlignmentButtons: false,
                        showHeaderStyle: false,
                        showListCheck: false,
                        showCodeBlock: false,
                        showQuote: false,
                        showIndent: false,
                        showLink: false,
                        showSearchButton: false,
                        showSubscript: false,
                        showSuperscript: false,
                        showFontFamily: false,
                        showFontSize: false,
                        showDividers: false,
                      ),
                    ),
                  ),

                  // Quill Editor
                  Container(
                    height: 200, // Fixed height untuk editor
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.outline),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(8),
                      ),
                    ),
                    child: quill.QuillEditor.basic(
                      configurations: quill.QuillEditorConfigurations(
                        controller: _descriptionController,
                        padding: const EdgeInsets.all(16),
                        placeholder: 'Describe your task in detail...',
                      ),
                    ),
                  ),

                  // Validation error message (if needed)
                  if (_descriptionController.document.isEmpty() &&
                      _showDescriptionError)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 12),
                      child: Text(
                        AppStrings.descriptionMinLength,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 24),

              // NEW: Date Picker Field
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(4),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: AppStrings.taskDueDate,
                    hintText: AppStrings.selectDate,
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: const OutlineInputBorder(),
                    errorText: _selectedDate == null
                        ? AppStrings.selectValidDate
                        : null,
                  ),
                  child: Text(
                    _selectedDate == null
                        ? AppStrings.selectDate
                        : DateFormat('EEEE, MMMM dd, yyyy')
                        .format(_selectedDate!),
                    style: TextStyle(
                      color: _selectedDate == null
                          ? Theme.of(context).hintColor
                          : Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // NEW: Category Dropdown
              DropdownButtonFormField<TaskCategory>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: AppStrings.taskCategory,
                  hintText: AppStrings.selectCategory,
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                items: TaskCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        // Category color indicator
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: _getCategoryColor(category),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(_getCategoryLabel(category)),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedCategory = value);
                },
                validator: (value) {
                  if (value == null) return AppStrings.selectValidCategory;
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // NEW: Priority Selection Label
              Text(
                AppStrings.taskPriority,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),

              // NEW: Adaptive Priority Radio Buttons dengan LayoutBuilder
              // ADAPTIVE: Row (wide screen) or Column (narrow screen)
              LayoutBuilder(
                builder: (context, constraints) {
                  // Breakpoint: 600px (Material Design standard for tablet)
                  final isWideScreen = constraints.maxWidth > 600;

                  // Wide screen: Horizontal layout (Row)
                  if (isWideScreen) {
                    return Row(
                      children: [
                        _buildPriorityRadio(TaskPriority.high, isWideScreen),
                        const SizedBox(width: 8),
                        _buildPriorityRadio(TaskPriority.medium, isWideScreen),
                        const SizedBox(width: 8),
                        _buildPriorityRadio(TaskPriority.low, isWideScreen),
                      ],
                    );
                  }

                  // Narrow screen: Vertical layout (Column)
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildPriorityRadio(TaskPriority.high, isWideScreen),
                      const SizedBox(height: 8),
                      _buildPriorityRadio(TaskPriority.medium, isWideScreen),
                      const SizedBox(height: 8),
                      _buildPriorityRadio(TaskPriority.low, isWideScreen),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // Save Button
              ElevatedButton(
                onPressed: _isLoading ? null : _saveTask,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Text(
                  AppStrings.save,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // NEW: Pick date dengan restrictions
  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(), // Can't select past dates
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  // NEW: Build priority radio button
  Widget _buildPriorityRadio(TaskPriority priority, bool isWideScreen) {
    final isSelected = _selectedPriority == priority;
    final color = _getPriorityColor(priority);

    final child = InkWell(
      onTap: () => setState(() => _selectedPriority = priority),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? color : AppColors.outline.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Radio indicator
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
                color: isSelected ? color : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 6),
            // Priority label
            Text(
              _getPriorityLabel(priority),
              style: TextStyle(
                color:
                isSelected ? color : AppColors.onSurface.withOpacity(0.7),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );

    // Use Expanded only for Row layout (wide screen)
    return isWideScreen ? Expanded(child: child) : child;
  }

  // NEW: Get category color
  Color _getCategoryColor(TaskCategory category) {
    switch (category) {
      case TaskCategory.study:
        return AppColors.categoryStudy;
      case TaskCategory.assignment:
        return AppColors.categoryAssignment;
      case TaskCategory.project:
        return AppColors.categoryProject;
      case TaskCategory.personal:
        return AppColors.categoryPersonal;
    }
  }

  // NEW: Get category label
  String _getCategoryLabel(TaskCategory category) {
    switch (category) {
      case TaskCategory.study:
        return AppStrings.categoryStudy;
      case TaskCategory.assignment:
        return AppStrings.categoryAssignment;
      case TaskCategory.project:
        return AppStrings.categoryProject;
      case TaskCategory.personal:
        return AppStrings.categoryPersonal;
    }
  }

  // NEW: Get priority color
  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return AppColors.priorityHigh;
      case TaskPriority.medium:
        return AppColors.priorityMedium;
      case TaskPriority.low:
        return AppColors.priorityLow;
    }
  }

  // NEW: Get priority label
  String _getPriorityLabel(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return AppStrings.priorityHigh;
      case TaskPriority.medium:
        return AppStrings.priorityMedium;
      case TaskPriority.low:
        return AppStrings.priorityLow;
    }
  }

  // CHANGED: Update _saveTask method
  void _saveTask() async {
    // Validate date
    if (_selectedDate == null) {
      setState(() {}); // Trigger rebuild untuk show error
      return;
    }

    // NEW: Validate rich text description (not empty)
    final descriptionPlainText = _descriptionController.document.toPlainText().trim();
    if (descriptionPlainText.isEmpty || descriptionPlainText.length < 10) {
      setState(() => _showDescriptionError = true);
      return;
    } else {
      setState(() => _showDescriptionError = false);
    }

    // Validate form (text fields & dropdown)
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Show loading state
    setState(() => _isLoading = true);

    // NEW: Get rich text content as Delta JSON string
    final descriptionDelta = _descriptionController.document.toDelta();
    final descriptionJson = descriptionDelta.toJson();
    // Convert to string untuk save to database/API
    final descriptionString = descriptionJson.toString();

    // NOTE: For now just simulate save
    // In P7 (Provider) & P9 (API), we'll actually save this rich text content
    print('Rich text description: $descriptionString');

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.taskCreated),
        backgroundColor: AppColors.statusCompleted,
        duration: Duration(seconds: 2),
      ),
    );

    // Navigate back
    Navigator.pop(context);
  }
}