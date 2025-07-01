import 'package:flutter/material.dart';
import '../../core/constants/strings/app_strings.dart';
import '../../core/constants/colors/app_colors.dart';
import '../../core/constants/app_constants.dart';

class QuickAddScreen extends StatefulWidget {
  const QuickAddScreen({super.key});

  @override
  State<QuickAddScreen> createState() => _QuickAddScreenState();
}

class _QuickAddScreenState extends State<QuickAddScreen> {
  int _selectedType = 0; // 0: Event, 1: Task, 2: Note

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
            decoration: const InputDecoration(
              labelText: AppStrings.eventTitle,
              hintText: 'Nhập tiêu đề sự kiện',
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextField(
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
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: AppStrings.startTime,
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  readOnly: true,
                ),
              ),
              const SizedBox(width: AppConstants.defaultPadding),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: AppStrings.endTime,
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  readOnly: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextField(
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
            decoration: const InputDecoration(
              labelText: AppStrings.taskTitle,
              hintText: 'Nhập tiêu đề nhiệm vụ',
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextField(
            decoration: const InputDecoration(
              labelText: AppStrings.taskDescription,
              hintText: 'Mô tả nhiệm vụ (tùy chọn)',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextField(
            decoration: const InputDecoration(
              labelText: AppStrings.dueDate,
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: AppStrings.priority),
            items: const [
              DropdownMenuItem(value: 'low', child: Text('Thấp')),
              DropdownMenuItem(value: 'medium', child: Text('Trung bình')),
              DropdownMenuItem(value: 'high', child: Text('Cao')),
              DropdownMenuItem(value: 'urgent', child: Text('Khẩn cấp')),
            ],
            onChanged: (value) {},
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
            decoration: const InputDecoration(
              labelText: 'Tiêu đề ghi chú',
              hintText: 'Nhập tiêu đề',
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Nội dung',
              hintText: 'Nhập nội dung ghi chú',
              alignLabelWithHint: true,
            ),
            maxLines: 8,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextField(
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

  void _save() {
    Navigator.pop(context);
  }
}
