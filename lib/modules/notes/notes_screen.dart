import 'package:flutter/material.dart';
import '../../core/constants/colors/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/models/notes/note.dart';
import '../../shared/services/notes/notes_service.dart';
import '../../shared/components/common/custom_app_bar.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NotesService _notesService = NotesService();
  final TextEditingController _searchController = TextEditingController();

  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  List<String> _tags = [];
  String _selectedTag = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadNotes();
    _loadTags();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final notes = await _notesService.getAllNotes();
      setState(() {
        _notes = notes;
        _filteredNotes = notes;
      });
    } catch (e) {
      // Error loading notes
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadTags() async {
    try {
      final tags = await _notesService.getAllTags();
      setState(() {
        _tags = tags;
      });
    } catch (e) {
      // Error loading tags
    }
  }

  void _filterNotes() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredNotes = _notes.where((note) {
        final matchesSearch =
            query.isEmpty ||
            note.title.toLowerCase().contains(query) ||
            note.content.toLowerCase().contains(query);

        final matchesTag =
            _selectedTag.isEmpty || note.tags.contains(_selectedTag);

        return matchesSearch && matchesTag;
      }).toList();
    });
  }

  void _onTagSelected(String tag) {
    setState(() {
      _selectedTag = _selectedTag == tag ? '' : tag;
    });
    _filterNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ghi chú', showBackButton: false),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm ghi chú...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _filterNotes();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    _filterNotes();
                  },
                ),

                const SizedBox(height: AppConstants.defaultPadding),

                // Tags Filter
                if (_tags.isNotEmpty)
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _tags.length,
                      itemBuilder: (context, index) {
                        final tag = _tags[index];
                        final isSelected = _selectedTag == tag;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(tag),
                            selected: isSelected,
                            onSelected: (selected) => _onTagSelected(tag),
                            backgroundColor: AppColors.grey100,
                            selectedColor: AppColors.primaryBlue.withValues(
                              alpha: 0.2,
                            ),
                            checkmarkColor: AppColors.primaryBlue,
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // Notes List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredNotes.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding,
                    ),
                    itemCount: _filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = _filteredNotes[index];
                      return _buildNoteCard(note);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteEditor(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_add, size: 64, color: AppColors.grey300),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isNotEmpty || _selectedTag.isNotEmpty
                ? 'Không tìm thấy ghi chú nào'
                : 'Chưa có ghi chú nào',
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchController.text.isNotEmpty || _selectedTag.isNotEmpty
                ? 'Thử tìm kiếm với từ khóa khác'
                : 'Nhấn + để tạo ghi chú đầu tiên',
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: InkWell(
        onTap: () => _showNoteEditor(note: note),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (note.isPinned)
                    const Icon(
                      Icons.push_pin,
                      size: 16,
                      color: AppColors.primaryBlue,
                    ),
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    onSelected: (value) => _handleNoteAction(value, note),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'pin',
                        child: Row(
                          children: [
                            Icon(
                              note.isPinned
                                  ? Icons.push_pin_outlined
                                  : Icons.push_pin,
                            ),
                            const SizedBox(width: 8),
                            Text(note.isPinned ? 'Bỏ ghim' : 'Ghim'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Xóa', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                note.content,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              if (note.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: note.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 8),

              Text(
                'Cập nhật: ${_formatDate(note.updatedAt)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Hôm qua';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _handleNoteAction(String action, Note note) async {
    switch (action) {
      case 'pin':
        await _notesService.togglePin(note.id);
        _loadNotes();
        break;
      case 'delete':
        _showDeleteConfirmation(note);
        break;
    }
  }

  void _showDeleteConfirmation(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa ghi chú "${note.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _notesService.deleteNote(note.id);
              _loadNotes();
              _loadTags();
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showNoteEditor({Note? note}) {
    // For now, just reload notes
    _loadNotes();
    _loadTags();
  }
}
