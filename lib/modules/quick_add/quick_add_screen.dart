import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/strings/app_strings.dart';
import '../../core/constants/colors/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/models/calendar/calendar_event.dart';
import '../../shared/models/tasks/task.dart';
import '../../shared/models/notes/note.dart';
import '../../shared/services/database/database_service.dart';
import '../../shared/services/notes/notes_service.dart';

class QuickAddScreen extends StatefulWidget {
  const QuickAddScreen({super.key});

  @override
  State<QuickAddScreen> createState() => _QuickAddScreenState();
}

class _QuickAddScreenState extends State<QuickAddScreen> {
  int _selectedType = 0; // 0: Event, 1: Task, 2: Note

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  // Form data
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay(
    hour: TimeOfDay.now().hour + 1,
    minute: TimeOfDay.now().minute,
  );
  String _priority = 'medium';

  // Services
  final DatabaseService _databaseService = DatabaseService();
  final NotesService _notesService = NotesService();
  final Uuid _uuid = const Uuid();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.largePadding),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Thêm nhanh',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Type Selector
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildTypeButton(
                    index: 0,
                    title: 'Sự kiện',
                    icon: Icons.event,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTypeButton(
                    index: 1,
                    title: 'Nhiệm vụ',
                    icon: Icons.task_alt,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTypeButton(
                    index: 2,
                    title: 'Ghi chú',
                    icon: Icons.note_add,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppConstants.largePadding),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: _buildContent(),
            ),
          ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(AppStrings.cancel),
                  ),
                ),
                const SizedBox(width: AppConstants.defaultPadding),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _save,
                    child: const Text(AppStrings.save),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton({
    required int index,
    required String title,
    required IconData icon,
  }) {
    final isSelected = _selectedType == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.grey100,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.white : AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.textSecondary,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedType) {
      case 0:
        return _buildEventForm();
      case 1:
        return _buildTaskForm();
      case 2:
        return _buildNoteForm();
      default:
        return Container();
    }
  }

  Widget _buildEventForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: AppStrings.eventTitle,
              hintText: 'Nhập tiêu đề sự kiện',
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: AppStrings.eventDescription,
              hintText: 'Mô tả sự kiện (tùy chọn)',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectTime(context, true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey300),
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Bắt đầu: ${_startTime.format(context)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.defaultPadding),
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectTime(context, false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey300),
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Kết thúc: ${_endTime.format(context)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Địa điểm',
              hintText: 'Nhập địa điểm (tùy chọn)',
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: AppStrings.taskTitle,
              hintText: 'Nhập tiêu đề nhiệm vụ',
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: AppStrings.taskDescription,
              hintText: 'Mô tả nhiệm vụ (tùy chọn)',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey300),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Hạn: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          DropdownButtonFormField<String>(
            value: _priority,
            decoration: const InputDecoration(labelText: AppStrings.priority),
            items: const [
              DropdownMenuItem(value: 'low', child: Text('Thấp')),
              DropdownMenuItem(value: 'medium', child: Text('Trung bình')),
              DropdownMenuItem(value: 'high', child: Text('Cao')),
              DropdownMenuItem(value: 'urgent', child: Text('Khẩn cấp')),
            ],
            onChanged: (value) {
              setState(() {
                _priority = value ?? 'medium';
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoteForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Tiêu đề ghi chú',
              hintText: 'Nhập tiêu đề',
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Nội dung',
              hintText: 'Nhập nội dung ghi chú',
              alignLabelWithHint: true,
            ),
            maxLines: 8,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextField(
            controller: _tagsController,
            decoration: const InputDecoration(
              labelText: AppStrings.tags,
              hintText: 'Thêm thẻ (cách nhau bằng dấu phẩy)',
              prefixIcon: Icon(Icons.label),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
          // Auto-adjust end time to be 1 hour after start time
          _endTime = TimeOfDay(
            hour: (picked.hour + 1) % 24,
            minute: picked.minute,
          );
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _save() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vui lòng nhập tiêu đề')));
      return;
    }

    try {
      switch (_selectedType) {
        case 0: // Event
          await _saveEvent();
          break;
        case 1: // Task
          await _saveTask();
          break;
        case 2: // Note
          await _saveNote();
          break;
      }

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đã lưu thành công!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    }
  }

  Future<void> _saveEvent() async {
    final startDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _startTime.hour,
      _startTime.minute,
    );
    final endDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _endTime.hour,
      _endTime.minute,
    );

    final event = CalendarEvent(
      id: _uuid.v4(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      startTime: startDateTime,
      endTime: endDateTime,
      location: _locationController.text.trim(),
      color: '#2196F3',
      tags: [],
      isAllDay: false,
      hasReminder: true,
      reminderMinutes: 15,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _databaseService.insertEvent(event);
  }

  Future<void> _saveTask() async {
    TaskPriority priority;
    switch (_priority) {
      case 'low':
        priority = TaskPriority.low;
        break;
      case 'high':
        priority = TaskPriority.high;
        break;
      case 'urgent':
        priority = TaskPriority.urgent;
        break;
      default:
        priority = TaskPriority.medium;
    }

    final task = Task(
      id: _uuid.v4(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      dueDate: _selectedDate,
      priority: priority,
      status: TaskStatus.pending,
      tags: [],
      repeat: TaskRepeat.none,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _databaseService.insertTask(task);
  }

  Future<void> _saveNote() async {
    final tags = _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    final note = Note(
      id: _uuid.v4(),
      title: _titleController.text.trim(),
      content: _descriptionController.text.trim(),
      tags: tags,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _notesService.createNote(note);
  }
}
